module 0x43a661208cc93ba4f98faccf399de986be0855a19e29c4b36265d49fb4ba288a::penai {
    struct PENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENAI>(arg0, 6, b"PENAI", b"Penguin AI", b"Project based on penguin ia, with a bot in development", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736031677309.18")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

