module 0xadf7345dc75204b9b3a00910300c2af1bf69c109b3940ff50cfae493e0b2ca10::bluef {
    struct BLUEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEF>(arg0, 6, b"BLUEF", b"Blue Eyed Fish", b"Blue-eyed fish on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dasdsa_d92ba15070.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

