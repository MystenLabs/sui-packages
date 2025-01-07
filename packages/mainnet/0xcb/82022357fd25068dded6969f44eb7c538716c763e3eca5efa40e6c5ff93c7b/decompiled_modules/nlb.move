module 0xcb82022357fd25068dded6969f44eb7c538716c763e3eca5efa40e6c5ff93c7b::nlb {
    struct NLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLB>(arg0, 6, b"NLB", b"NiGGA Look bacteria", b"This Nigga look like bacteria", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731947830695.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

