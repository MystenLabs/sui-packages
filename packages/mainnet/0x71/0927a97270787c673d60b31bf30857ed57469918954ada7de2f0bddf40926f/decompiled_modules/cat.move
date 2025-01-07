module 0x710927a97270787c673d60b31bf30857ed57469918954ada7de2f0bddf40926f::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"Cat", b"CAT", b"Cat is a Community driven fun and exciting memecoin on Sui! we plan to bring the times of big moonshots back to Sui! Cat welcomes all whales and investors to join us and make Sui Great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241013_003936_f3c9b04cd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

