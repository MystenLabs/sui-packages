module 0xfe79f1907ffd549ecc50bb0cfa50e3a2632a0594efaa15e8f709bab780bf0add::ilu {
    struct ILU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILU>(arg0, 6, b"ILU", b"I Love You", b"I Love You!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2358_85f6782580.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILU>>(v1);
    }

    // decompiled from Move bytecode v6
}

