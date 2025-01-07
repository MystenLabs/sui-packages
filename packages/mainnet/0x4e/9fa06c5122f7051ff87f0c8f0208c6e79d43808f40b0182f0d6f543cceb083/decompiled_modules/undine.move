module 0x4e9fa06c5122f7051ff87f0c8f0208c6e79d43808f40b0182f0d6f543cceb083::undine {
    struct UNDINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDINE>(arg0, 6, b"Undine", b"undine", x"54686520776174657220656c656d656e742069732074686520746f74656d206f662074686520736f756c2e204f757220636f6d6d756e6974792069732061626f757420746f206c61756e636820210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727980011772_67e11029c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNDINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

