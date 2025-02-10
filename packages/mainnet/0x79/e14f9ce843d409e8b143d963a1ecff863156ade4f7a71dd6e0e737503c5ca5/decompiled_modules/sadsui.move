module 0x79e14f9ce843d409e8b143d963a1ecff863156ade4f7a71dd6e0e737503c5ca5::sadsui {
    struct SADSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADSUI>(arg0, 6, b"SADSUI", b"SUISAD", x"245355495341442020546865204f6666696369616c2043757272656e6379206f66204e6f7420436172696e670a0a41206d656d6520636f696e20666f722074686f73652077686f277665207365656e20746f6f206d7563682e2057656c636f6d6520746f207468652073717561642e20596f752772652065697468657220616c7265616479206f6e65206f662075732e2e2e206f7220796f75276c6c2067657420746865726520736f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Random_7d24a31051.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

