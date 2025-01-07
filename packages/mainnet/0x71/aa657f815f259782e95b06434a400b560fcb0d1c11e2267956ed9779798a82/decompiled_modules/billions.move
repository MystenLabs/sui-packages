module 0x71aa657f815f259782e95b06434a400b560fcb0d1c11e2267956ed9779798a82::billions {
    struct BILLIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLIONS>(arg0, 6, b"BILLIONS", b"billions", b"BLLIONS OIEHFCIOUDE2HNOFH0UR2E0HUF4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/429705_8cacb5e826.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

