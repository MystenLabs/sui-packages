module 0xf65a567eb4142894225599b0657a4b8784dfa5cbef2ebbbbc3ead87a40be287e::moc {
    struct MOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOC>(arg0, 6, b"MOC", b"Mochi", b"The fluffly, squishy and hungry blob living his best life in the Sui universe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730980088004.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

