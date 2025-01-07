module 0x1f61c5a623d4ed7819b21a991e0661b6a5e26c9fcf03698c0c8dc20b640d9d00::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 9, b"SUIKO", b"Empress Suiko", x"54686520466972737420456d70726573730a0a4e4f2057454253495445202c204e4f20444953434f5244202c204e4f2054472c204e4f205554494c4954592121210a0a22576520646f6e742068617665207574696c697479202c20696620796f7572206c6f6f6b696e6720666f72207574696c69747920676f206170706c792061732061206a616e69746f7220220a0a444547454e20444547454e20444547454e21212121200a0a7e456d7072657373200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b64d2209407f80d15209b714485c814bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

