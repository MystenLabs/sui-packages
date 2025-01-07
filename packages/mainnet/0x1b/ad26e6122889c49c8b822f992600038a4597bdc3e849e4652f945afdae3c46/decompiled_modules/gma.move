module 0x1bad26e6122889c49c8b822f992600038a4597bdc3e849e4652f945afdae3c46::gma {
    struct GMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMA>(arg0, 6, b"GMA", b"Gluteus Maximus", x"476c7574657573204d6178696d75732c20612066756e206d656d65636f696e20666f72203230323521204b656570206865616c74687920616e642068617070792e0a544720616e6420747769747465722070656e64696e672e2054686973206973206120636f6d6d756e697479206d656d65636f696e2c206c6574277320676f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000188_db75ae3da7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

