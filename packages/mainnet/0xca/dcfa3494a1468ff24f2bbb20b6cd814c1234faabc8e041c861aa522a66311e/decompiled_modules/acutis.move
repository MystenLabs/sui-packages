module 0xcadcfa3494a1468ff24f2bbb20b6cd814c1234faabc8e041c861aa522a66311e::acutis {
    struct ACUTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACUTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACUTIS>(arg0, 6, b"Acutis", b"Carlos acutis", b"This currency will spread the honor and glory of Carlos Acutis, a decentralized and active currency. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020597_7f1882407a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACUTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACUTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

