module 0x7bc2807ff4ab4c74c09607503c9d7730614ac80bffcc823ef92e27f7509e5df6::ds {
    struct DS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DS>(arg0, 6, b"DS", b"DragSui", b"The dragon community will be the best and most solid where all supplies are controlled by the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/534d62fd_00c9_4eb4_97de_aadd89b744ae_1e1bfb2f70.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DS>>(v1);
    }

    // decompiled from Move bytecode v6
}

