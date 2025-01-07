module 0xff1edd21425ae2fe956356c3efe8e528e5e977f1a6f497efbff2089f5754f75c::andui {
    struct ANDUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDUI>(arg0, 6, b"ANDUI", b"Andy on Sui", x"486920696d20416e64790a0a49742069732074696d6520666f72206d6520746f206a6f696e20537569204e6574776f726b210a0a436f6d65206a6f696e206d65206173206920656d6261726b206d79206a6f75726e6579206f6e2053756920426c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/andy_on_sui_logo_0de391d615.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

