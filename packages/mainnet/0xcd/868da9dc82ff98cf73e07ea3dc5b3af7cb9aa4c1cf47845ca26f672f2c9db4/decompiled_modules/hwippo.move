module 0xcd868da9dc82ff98cf73e07ea3dc5b3af7cb9aa4c1cf47845ca26f672f2c9db4::hwippo {
    struct HWIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWIPPO>(arg0, 6, b"HWIPPO", b"hwippo coin", b"In the ashes a community emerged, a new hippo, a more based hippo, a Hwippo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HWIPPO_aecbcc52c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HWIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

