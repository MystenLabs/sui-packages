module 0x407eb949e8fd55bd997123c32c285b942152b838cdea65a8e4e009b4b40c9b65::dogai {
    struct DOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGAI>(arg0, 6, b"DOGAI", b"DOGAI", b"Dogai to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0dog3_9a14606b3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

