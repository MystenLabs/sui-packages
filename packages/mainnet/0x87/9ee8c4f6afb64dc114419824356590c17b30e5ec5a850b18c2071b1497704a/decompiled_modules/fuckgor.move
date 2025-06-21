module 0x879ee8c4f6afb64dc114419824356590c17b30e5ec5a850b18c2071b1497704a::fuckgor {
    struct FUCKGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKGOR>(arg0, 8, b"FUCKGOR", b"FUCKGOR", b"FUCKGOR on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/16e6b7e3-0204-498a-95ae-07e09629faa5.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUCKGOR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKGOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKGOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

