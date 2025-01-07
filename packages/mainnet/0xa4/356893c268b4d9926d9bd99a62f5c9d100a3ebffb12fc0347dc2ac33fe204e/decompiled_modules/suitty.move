module 0xa4356893c268b4d9926d9bd99a62f5c9d100a3ebffb12fc0347dc2ac33fe204e::suitty {
    struct SUITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTY>(arg0, 6, b"SUITTY", b"Suittu Sui", x"535549206669727374206368616f73206167656e7420776974682061206865617274206f6620676f6c6420616e64206120627261696e2066756c6c206f6620676c69747465722e0a0a0a0a5355495454592069736e277420796f757220617665726167652063727970746f206d6173636f742e20486527732061207175616e74756d20616e6f6d616c79206f66206a6f792c20612077616c6b696e672070617261646f78206f662066696e616e6369616c20776973646f6d20616e642061646f7261626c6520636f6e667573696f6e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000428_50c76972ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

