module 0x7b0cb476add369f196afddd4accf490e18d5f833c3565a9c653317320eacb483::ssec {
    struct SSEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSEC>(arg0, 6, b"SSEC", b"Chinese Stock Market", x"56657279205374726f6e672c20566572746963616c204d6f7665732c204d61737369766520496e666c6f77202d204368696e657365205765616c74680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Zz_U1h_1_400x400_0327caedb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

