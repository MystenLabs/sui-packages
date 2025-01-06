module 0xb94f03f2716ba0065240257f542cec5caa638676a7420fce0e9e09357ef9c13b::cruz {
    struct CRUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUZ>(arg0, 6, b"CRUZ", b"CRUZ THE UGLY CAT", b"Meet $CRUZ, the ugly cat who's about to change the sui memes world. Because \"ugly is the new cute\" JOIN US!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_pp_7aa3f618a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

