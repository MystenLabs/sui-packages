module 0x29f610494942790657fc916936baa49743dc5da996091d4b2abcdde52553b9e6::isui {
    struct ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUI>(arg0, 6, b"ISUI", b"ISUICOIN", b"$ISUI is a memecoin representative for IKEA company.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/92c3c69f_8394_4b5a_b2b1_1fa0685e5fd8_73ffd870d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

