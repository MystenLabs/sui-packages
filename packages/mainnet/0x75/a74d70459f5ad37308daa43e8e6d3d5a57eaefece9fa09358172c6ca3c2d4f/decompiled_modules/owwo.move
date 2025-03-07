module 0x75a74d70459f5ad37308daa43e8e6d3d5a57eaefece9fa09358172c6ca3c2d4f::owwo {
    struct OWWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWWO>(arg0, 6, b"OWWO", b"Owwo on Sui", b"owwo the biggest OWLTO on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070506_f32d6a51b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

