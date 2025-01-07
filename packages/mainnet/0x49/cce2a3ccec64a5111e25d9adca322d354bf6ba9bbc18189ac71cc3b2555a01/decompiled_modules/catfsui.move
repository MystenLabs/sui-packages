module 0x49cce2a3ccec64a5111e25d9adca322d354bf6ba9bbc18189ac71cc3b2555a01::catfsui {
    struct CATFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFSUI>(arg0, 6, b"CATFSUI", b"CATFAMILYSUI", x"5765206c6f7665202446434154204c696b6520796f752e2024464341542066616d696c7920616c6c20696e206f6e6520706c6163650a0a68747470733a2f2f742e6d652f63617466616d696c796d756c74636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031226_0e61304d7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

