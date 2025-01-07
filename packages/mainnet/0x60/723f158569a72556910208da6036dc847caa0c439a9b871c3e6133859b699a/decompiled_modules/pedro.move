module 0x60723f158569a72556910208da6036dc847caa0c439a9b871c3e6133859b699a::pedro {
    struct PEDRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDRO>(arg0, 6, b"PEDRO", b"Pedro the Raccoon", x"4a6f696e206f7572206d656d652063727970746f63757272656e63790a696e73706972656420627920506564726f2074686520526163636f6f6e206d656d652e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RAC_8b220f69bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

