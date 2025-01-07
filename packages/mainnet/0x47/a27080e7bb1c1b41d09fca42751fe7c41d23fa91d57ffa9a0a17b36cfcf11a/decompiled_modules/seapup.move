module 0x47a27080e7bb1c1b41d09fca42751fe7c41d23fa91d57ffa9a0a17b36cfcf11a::seapup {
    struct SEAPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAPUP>(arg0, 6, b"SEAPUP", b"SEA PUP", b"The little seal who became the favorite of the whole sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/distressed_design_for_funny_chroma_t_shirt_cute_c_ff7e86511e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

