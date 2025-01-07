module 0x24c7e040377f0c9b76ab2c4e629233013bf7f9ee8220ae823f03bc6190c370c4::waves {
    struct WAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVES>(arg0, 6, b"WAVES", b"Sui Waves", b"A token riding the tides of innovation on the SUI blockchain, bringing fluidity, speed, and endless possibilities to DeFi. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_29_165445_e446603675.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

