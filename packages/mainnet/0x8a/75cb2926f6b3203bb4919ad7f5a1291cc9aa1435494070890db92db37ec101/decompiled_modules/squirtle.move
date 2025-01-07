module 0x8a75cb2926f6b3203bb4919ad7f5a1291cc9aa1435494070890db92db37ec101::squirtle {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLE>(arg0, 6, b"Squirtle", b"Squirtle on sui", x"5371756972746c6520284a6170616e6573653a202c20456e676c6973683a205371756972746c652920697320612057617465722d61747472696275746520506f6b6d6f6e20616e64206f6e65206f6620746865206f726967696e616c20636f6d70616e696f6e7320696e20746865204b616e746f20726567696f6e2e204974207761732064657369676e656420627920417473756b6f204e6973686964612e0a0a4e6f772069742068617320636f6d6520746f20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_e_ee4f2d0c43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

