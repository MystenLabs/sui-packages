module 0xbe0ca8baa27e7e9af614569c5aa83a91ecba57e4e38a8039cc3bd7be12f4fb04::pepesadsui {
    struct PEPESADSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESADSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESADSUI>(arg0, 6, b"PEPESADSUI", b"PEPESAD", b"Routine life got you down? Get rich and turn up the fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_logo_f91d634093.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESADSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESADSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

