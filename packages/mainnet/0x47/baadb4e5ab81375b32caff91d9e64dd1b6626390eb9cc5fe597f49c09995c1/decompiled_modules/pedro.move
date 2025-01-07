module 0x47baadb4e5ab81375b32caff91d9e64dd1b6626390eb9cc5fe597f49c09995c1::pedro {
    struct PEDRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDRO>(arg0, 6, b"PEDRO", b"Pedro The Sui Bull", b"Pedro is a bull who lives in the Sui network, he loves nature and tranquility. He is an expert in finance and making your money grow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pedrohead_1c872ef913.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

