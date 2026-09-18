module 0xcaf03da917402a923b84c0db1f4386cfadbe803157c41e325835edf5eb80464a::suidoodle {
    struct SUIDOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOODLE>(arg0, 6, b"Suidoodle", b"Sui Doodle", b" The official mascot of SUI's high-speed network. Drawn with zero skill. Join the army of doodles. High Tech. Low Art. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789761865662.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOODLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOODLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

