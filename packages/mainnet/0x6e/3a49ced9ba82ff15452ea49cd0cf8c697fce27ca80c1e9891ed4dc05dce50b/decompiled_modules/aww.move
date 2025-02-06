module 0x6e3a49ced9ba82ff15452ea49cd0cf8c697fce27ca80c1e9891ed4dc05dce50b::aww {
    struct AWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWW>(arg0, 9, b"AWW", b"AXX", b"SS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.thenounproject.com/png/447685-200.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

