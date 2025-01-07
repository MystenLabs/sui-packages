module 0xd32305a19e0ba47a72d48624a01d236cc88aca51c4e1128df6d4983a254405f6::mootoon {
    struct MOOTOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOTOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOTOON>(arg0, 6, b"MOOTOON", b"MOOTOONtoken", x"4d6f7265206d61726b6574696e67206973206f6e20746865207761792e0a0a244d4f4f544f4f4e204953204d45414e204d4f4f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kpva_Jly_400x400_66bef1f5aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOTOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOTOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

