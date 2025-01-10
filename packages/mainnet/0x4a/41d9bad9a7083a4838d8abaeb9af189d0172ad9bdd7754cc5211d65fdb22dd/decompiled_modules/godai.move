module 0x4a41d9bad9a7083a4838d8abaeb9af189d0172ad9bdd7754cc5211d65fdb22dd::godai {
    struct GODAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GODAI>(arg0, 6, b"GODAI", b"HANUMAN by SuiAI", b"God of AI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000015108_9637b2dc73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GODAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

