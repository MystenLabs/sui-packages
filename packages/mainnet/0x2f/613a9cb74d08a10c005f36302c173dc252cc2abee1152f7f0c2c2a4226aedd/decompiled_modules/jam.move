module 0x2f613a9cb74d08a10c005f36302c173dc252cc2abee1152f7f0c2c2a4226aedd::jam {
    struct JAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAM>(arg0, 6, b"JAM", b"JUST A MEME", x"5765277265206d6f7265207468616e206a7573742061206d656d6521210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GV_Ky_P_Dq_WUAAC_Ilm_0a112f2dc2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

