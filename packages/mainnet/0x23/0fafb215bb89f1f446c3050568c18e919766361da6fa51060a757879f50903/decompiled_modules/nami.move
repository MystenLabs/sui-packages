module 0x230fafb215bb89f1f446c3050568c18e919766361da6fa51060a757879f50903::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 9, b"NAMI", b"Nami", b"Nami the Cat Burglar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/EXDGHEk.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

