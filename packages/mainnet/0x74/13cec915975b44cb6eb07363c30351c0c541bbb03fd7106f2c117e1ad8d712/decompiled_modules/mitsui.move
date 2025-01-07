module 0x7413cec915975b44cb6eb07363c30351c0c541bbb03fd7106f2c117e1ad8d712::mitsui {
    struct MITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITSUI>(arg0, 6, b"MITSUI", b"MITSUIBISHI", b"The first meme car on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mitshubishi_d70ef8bbf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

