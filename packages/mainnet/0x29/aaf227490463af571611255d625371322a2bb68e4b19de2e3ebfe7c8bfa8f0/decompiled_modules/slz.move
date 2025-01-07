module 0x29aaf227490463af571611255d625371322a2bb68e4b19de2e3ebfe7c8bfa8f0::slz {
    struct SLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLZ>(arg0, 6, b"SLZ", b"STYLISH  LIZARD SUI", x"5374796c697368204c697a61726420697320616e20696775616e61207468617420697320646966666572656e742066726f6d206f7468657220696775616e6173207468697320696775616e612068617320612072657075746174696f6e20666f72207374796c6520616e642066617368696f6e2077686963682077696c6c2068656c70207468697320696775616e612068617665206120666c617368792074696d650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snapedit_1728023111504_5d1bb90e00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

