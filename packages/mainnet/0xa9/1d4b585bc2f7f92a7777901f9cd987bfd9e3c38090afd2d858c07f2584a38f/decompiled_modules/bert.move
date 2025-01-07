module 0xa91d4b585bc2f7f92a7777901f9cd987bfd9e3c38090afd2d858c07f2584a38f::bert {
    struct BERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERT>(arg0, 6, b"Bert", b"Whalebert", x"5768616c6562657274202d205768616c65666f756e646174696f6e0a0a44657620537570706c792077696c6c20626520757365642061732072657365727665727320746f2067656e65726174652066656573207769746820646966666572656e74204c697175696469747920506f6f6c7320706169726564207769746820646966666572656e7420546f6b656e7320646563696465642062792074686520436f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Neues_Projekt_3_5085348820.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

