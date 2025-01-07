module 0xf12720049b05d8cc4097311805bdec12b1ebac076c51998d573654fab42caab0::long {
    struct LONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONG>(arg0, 6, b"LONG", b"LONG ON SUI", x"244c4f4e4720426f726e20746f2064656665617420616c6c20746865206a6565747320616e642062656172732c20244c4f4e472074686520447261676f6e2072697365732061732074686520756c74696d6174652070726f746563746f72206f6620746865206d656d65636f696e207265616c6d210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/dwog_13b52f23bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

