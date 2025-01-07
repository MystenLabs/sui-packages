module 0x248acee3d81bb97fedfbb83fc7f09093f2f391502a7f6b1150291632b765f15d::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 6, b"SCB", b"Scabam", b"$SCB is native memecoin on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge_W46_M_Zas_AA_Jwmy_b351c4e051.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

