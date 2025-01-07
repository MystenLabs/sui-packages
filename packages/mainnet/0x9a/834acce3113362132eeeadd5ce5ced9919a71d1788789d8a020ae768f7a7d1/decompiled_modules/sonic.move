module 0x9a834acce3113362132eeeadd5ce5ced9919a71d1788789d8a020ae768f7a7d1::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 6, b"Sonic", b"Sui-Personic", b"Sui-personic to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Progetto_senza_titolo_5_88918edfd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

