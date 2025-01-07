module 0x4c60143417a37e3eb8966a9f997a388ea285805d2e8cd311078b09151bad81f0::buynt {
    struct BUYNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYNT>(arg0, 6, b"BUYNT", b"DO BUYN'T", b"Don't buy, I crate for airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdasdasdasdasd_0b2dc3c7a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUYNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

