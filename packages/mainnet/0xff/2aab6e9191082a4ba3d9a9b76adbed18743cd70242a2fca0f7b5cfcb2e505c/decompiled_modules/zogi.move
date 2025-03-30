module 0xff2aab6e9191082a4ba3d9a9b76adbed18743cd70242a2fca0f7b5cfcb2e505c::zogi {
    struct ZOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOGI>(arg0, 6, b"ZOGI", b"Zogi", x"5a6f67692063616d6f75666c6167657320696e746f2061207374726f6e6720616e6420706f77657266756c206c79696e6720666973680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052285_4713388c3b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

