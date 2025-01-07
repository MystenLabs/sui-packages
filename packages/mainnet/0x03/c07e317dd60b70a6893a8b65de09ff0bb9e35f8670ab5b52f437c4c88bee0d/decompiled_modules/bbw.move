module 0x3c07e317dd60b70a6893a8b65de09ff0bb9e35f8670ab5b52f437c4c88bee0d::bbw {
    struct BBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBW>(arg0, 6, b"BBW", b"Beeg Blue Whale", x"5068656e6f6d656e6f6e205768616c65206f66207468652023537569204f6365616e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BBG_49ff03959e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

