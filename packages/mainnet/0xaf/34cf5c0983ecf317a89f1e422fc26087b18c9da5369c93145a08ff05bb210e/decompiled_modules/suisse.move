module 0xaf34cf5c0983ecf317a89f1e422fc26087b18c9da5369c93145a08ff05bb210e::suisse {
    struct SUISSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSE>(arg0, 6, b"SUISSE", b"https://suisseblockchain.io/", b"Trusted projects. Opportunities for everyone. SuissePad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7jx_MN_1_i_400x400_e67d2f88d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

