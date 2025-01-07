module 0x8d9ae0cdb9f789b35c5f15c0ac9aedb41dc07c58aa51a39be58823d60f5612ef::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"SUIB", b"Suiba Inu", b"Emerging from Shiba's boundless love, Suiba, your liquid companion, journeys with you on the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_56bb74ae08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

