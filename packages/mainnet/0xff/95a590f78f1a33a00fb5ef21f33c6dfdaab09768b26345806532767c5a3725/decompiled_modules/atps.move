module 0xff95a590f78f1a33a00fb5ef21f33c6dfdaab09768b26345806532767c5a3725::atps {
    struct ATPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATPS>(arg0, 9, b"ATPS", b"ATPS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://play-lh.googleusercontent.com/KLG_W9OPcwhTwnD_EP90lzkAV0QRmMdwFzD-tICaCKfPaNgL0HQt3hhdgE2Z-RNrxhI=w240-h480-rw")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATPS>>(v1);
        0x2::coin::mint_and_transfer<ATPS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATPS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

