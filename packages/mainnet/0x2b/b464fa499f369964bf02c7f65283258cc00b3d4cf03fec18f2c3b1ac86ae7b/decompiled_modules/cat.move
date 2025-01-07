module 0x2bb464fa499f369964bf02c7f65283258cc00b3d4cf03fec18f2c3b1ac86ae7b::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"Cat", b"CAT", b"Cat is a Community driven fun and exciting memecoin on Sui! we plan to bring the times of big moonshots back to Sui! Cat welcomes all whales and investors to join us and make Sui Great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241013_003936_168989f7b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

