module 0x3211df88f361b9c663d5a577178786826702aa7f27e19b90a621ddde3317b597::suipercycle {
    struct SUIPERCYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERCYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERCYCLE>(arg0, 6, b"Suipercycle", b"Suipercycle (real) CTO", x"466972737420646576206a6565746564206869732062616720616e6420646f6e277420756e6465727374616e6420686f772062756c6c6973682074686973207469636b6572206973202120596f752077616e7420746f2062652070617274206f66207468652043544f207375697065726379636c6520210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Votre_texte_de_paragraphe_18_4dca33b59d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERCYCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERCYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

