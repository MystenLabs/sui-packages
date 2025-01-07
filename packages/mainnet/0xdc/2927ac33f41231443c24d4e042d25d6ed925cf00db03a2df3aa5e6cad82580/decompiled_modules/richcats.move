module 0xdc2927ac33f41231443c24d4e042d25d6ed925cf00db03a2df3aa5e6cad82580::richcats {
    struct RICHCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHCATS>(arg0, 9, b"RICHCATS", b"RICHCAT$", x"52494348434154242069732061205375692d6261736564206d656d6520746f6b656e20666f722074686f73652077686f206372617665207765616c74682c206865616c74682c20616e6420737563636573732e204d6f7265207468616e206d6f6e65792c207765206d616e6966657374206162756e64616e636520696e2065766572792070617274206f66206c69666520e2809420696e7369646520616e64206f75742e204a6f696e206120636f6d6d756e697479207468617420746872697665732c2077696e732c20616e642061747472616374732070726f737065726974792e20507572726665637420796f7572206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5826d83c-1253-492e-881f-7df540559997.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

