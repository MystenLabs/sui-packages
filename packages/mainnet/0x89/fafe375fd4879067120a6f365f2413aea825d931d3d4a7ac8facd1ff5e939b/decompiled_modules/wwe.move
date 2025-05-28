module 0x89fafe375fd4879067120a6f365f2413aea825d931d3d4a7ac8facd1ff5e939b::wwe {
    struct WWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWE>(arg0, 6, b"WWE", b"WE WRESTLE EVERYTHING", b" The ultimate crypto cage match in the WWE arena of blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_3xnei3_400x400_1fb5f13776.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

