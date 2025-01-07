module 0xa7184a6977b6812d0a03e8ddcd2d0c7617d7c0c2eee3d22e2ffe051f9f9b7e4f::pam {
    struct PAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAM>(arg0, 6, b"PAM", b"Pam the Bird", b"Pam the bird is a prominent Graffiti tag throughout Melbourne Aus. Pam exists in many forms. He is a symbol of rebellion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048491_1418922968.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

