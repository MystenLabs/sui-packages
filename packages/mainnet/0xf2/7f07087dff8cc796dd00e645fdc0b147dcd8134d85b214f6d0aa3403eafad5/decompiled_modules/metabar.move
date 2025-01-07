module 0xf27f07087dff8cc796dd00e645fdc0b147dcd8134d85b214f6d0aa3403eafad5::metabar {
    struct METABAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: METABAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METABAR>(arg0, 6, b"MetaBar", b"MetaBar ", x"4d6574614261722078204d616e616e6142617220212047616d654669202c204d656d65732c2052656465656d61626c204e465427732c2041697264726f707321200a0a537570706f7274206c6f63616c20627573696e65737320616e64206d616b65206974206120676c6f62616c2061646f7074696f6e2021204d65746142617220746f6b656e732077696c6c206265207573656420617320626172207061796d656e74732c20686f706566756c6c7920676c6f62616c6c7920616e6420696e20796f7572206c6f63616c2062617221200a0a4d657461426172204f47204261676465202d3e636c61696d206e6f77206f6e20424153452d3e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732217189439.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METABAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METABAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

