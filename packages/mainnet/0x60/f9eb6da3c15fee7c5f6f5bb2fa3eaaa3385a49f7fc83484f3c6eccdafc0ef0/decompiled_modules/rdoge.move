module 0x60f9eb6da3c15fee7c5f6f5bb2fa3eaaa3385a49f7fc83484f3c6eccdafc0ef0::rdoge {
    struct RDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOGE>(arg0, 6, b"RDOGE", b"RichDOGE", b"Do You Want To Be Rich ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_E347_JD_0_400x400_e135c2d3e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

