module 0xc42d527dcfcdf63f6439c5e99227b49885fd90aca52ed15c19e5a0dc27f58fa::aquape {
    struct AQUAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAPE>(arg0, 6, b"AQUAPE", b"Aqua Pepe", b"Aqua Pepe is a new memecoin in the Sui ecosystem that blends aquatic themes with the iconic character \"Pepe the Frog.\" With its unique style and refreshing vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241106_201721_bac1fc06a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

