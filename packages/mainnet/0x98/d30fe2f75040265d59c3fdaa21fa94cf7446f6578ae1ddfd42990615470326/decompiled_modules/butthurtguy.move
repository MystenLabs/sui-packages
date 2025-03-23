module 0x98d30fe2f75040265d59c3fdaa21fa94cf7446f6578ae1ddfd42990615470326::butthurtguy {
    struct BUTTHURTGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTHURTGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTHURTGUY>(arg0, 9, b"ButtHurtGuy", b"Butt Hurt Guy Mafia", x"546865206d656d6520636f696e206d61666961206973206120667265616b696e67206a6f6b652e204973206a7573742061206775792c206120627574742068757274206775792e20486520676f742063617567687420736c697070696e672c20616e64206e6f77206869732061737320697320746f6173742e20535549e280997320626c6f77696e67207570207769746820756e6c696d697465642067726f7774682c20616e64206865e280997320737475636b2061732042757474687572746775792077697468206120777265636b6564206261636b736964652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/xB81ZMB.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTHURTGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTHURTGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

