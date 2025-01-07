module 0x41151ad577e7a5ce3ca177d13861526d9beb9c29177efbd95012ff1b424bf2d5::sucared {
    struct SUCARED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCARED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCARED>(arg0, 6, b"SUCARED", b"$SUCARED", b"$SUCARED is a token on the Sui network, meaning \"Sui Scared,\" representing how incredibly powerful Sui is as it prepares to soar high in next year's bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_tw_94a1aa732e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCARED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCARED>>(v1);
    }

    // decompiled from Move bytecode v6
}

