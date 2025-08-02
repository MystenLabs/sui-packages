module 0xaaa54a0b5e72c10345783e74bd7d05c80464f1bb7dffce1ba38b37a62a88c48d::BOATKID {
    struct BOATKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOATKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOATKID>(arg0, 6, b"Pacu Jalur", b"boatkid", b"$BOATKID isn't just another memecoin. It's a movement powered by culture, community, and timing. Inspired by Pacu Jalur, a centuries-old Indonesian boat racing festival, it rides the waves of tradition straight into the heart of Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/dc69d9ef-d78c-4616-a86c-d38daef4a8bc")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOATKID>>(v0, @0xa38dd7b6257fec9b0661550b75b9464ddb54e582fa9f83e69b035d87333915cd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOATKID>>(v1);
    }

    // decompiled from Move bytecode v6
}

