module 0x7ce0d1bede781cedc9d00ee1ff8108e1eb1690350661c2d35f98f9784bb77b6e::oktestok {
    struct OKTESTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKTESTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742378787646.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<OKTESTOK>(arg0, 6, b"OTO", b"OkTestOk", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKTESTOK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKTESTOK>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<OKTESTOK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OKTESTOK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

