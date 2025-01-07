module 0x5364c520b2cb5b2e38e929f455ea20f8a0ed1155087c3d2b8d78c695f1f195e::notai {
    struct NOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTAI>(arg0, 6, b"NotAI", b"Not AI", b"Currently, AI is prevalent, generating a large amount of garbage content on the internet, taking away jobs from some people. Furthermore, in the future, AI may no longer be under human control. It is time for someone to stand up and question AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Frame_1_8_e14fcea450.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

