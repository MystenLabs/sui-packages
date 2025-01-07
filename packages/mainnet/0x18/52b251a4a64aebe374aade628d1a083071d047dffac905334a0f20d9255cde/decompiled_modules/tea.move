module 0x1852b251a4a64aebe374aade628d1a083071d047dffac905334a0f20d9255cde::tea {
    struct TEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEA>(arg0, 6, b"TEA", b"teatoken", x"2454454120697320612066756e206d656d6520636f696e206f6e2073756920666f722073686172696e6720746865206265737420676f7373697020616e642073746f72696573202874686520544541292e205370696c6c20746865207465612026206472696e6b20746865207465610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tj1_Yyb7_J_400x400_fe4236bdda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

