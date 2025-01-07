module 0x76aae4613bf0da9d8c35d9062fdf5e7a5dd61bbb4981fa185b3341bcaa2cd12b::notai {
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

