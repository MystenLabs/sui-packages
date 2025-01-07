module 0xc837012cfda26d83ef87361a4d71efaf64a5f2873a1a28ed3f165d6b569887d4::vap {
    struct VAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAP>(arg0, 6, b"VAP", b"Virtuals Ai Protocol", b"This interface consists of a set of APIs and SDKs that enable seamless integration between external applications and the Virtuals Agent Composer. This bi-directional interface allows applications to invoke AI agents' services for various computational tasks or user interactions, facilitating dynamic and responsive AI-driven functionalities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5876_9c0eaf501d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

