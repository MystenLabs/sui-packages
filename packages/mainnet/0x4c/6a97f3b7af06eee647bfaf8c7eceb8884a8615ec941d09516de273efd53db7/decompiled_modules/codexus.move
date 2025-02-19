module 0x4c6a97f3b7af06eee647bfaf8c7eceb8884a8615ec941d09516de273efd53db7::codexus {
    struct CODEXUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODEXUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODEXUS>(arg0, 6, b"Codexus", b"CODEXUS", x"456c65766174696e672041492d44726976656e20446576656c6f706d656e740a54686520667574757265206f6620736f66747761726520646576656c6f706d656e742069732041492d706f77657265642e20436f64657875732069732061742074686520666f726566726f6e742c20656e61626c696e6720646576656c6f7065727320746f206275696c642c206f7074696d697a652c20616e64206465706c6f792041492d64726976656e20736f6c7574696f6e7320666173746572207468616e20657665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e8_QT_0_Eo_400x400_8f46da081c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODEXUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODEXUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

