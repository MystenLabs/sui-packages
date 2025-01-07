module 0x130a6f6afc3f1a262dfcdca2708207a0407846b8e18804e7f06b51bdec8e9ec::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Puf", b"Puf the pufferfish takes a puff, cruising the sui coral with a chill kind of stuff.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yes_2ff8101762.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

