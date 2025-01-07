module 0xf5d23ef509096778f86702c917e1e58f0f5d0215500b90766d1adb64d8a5ca99::atlantis {
    struct ATLANTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLANTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATLANTIS>(arg0, 6, b"ATLANTIS", b"Atlantis on Sui", b"Atlantis the land of the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_4ea8f8f74b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLANTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATLANTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

