module 0xd1638b678d153b237995aeedd61e06eaf8d453ff2cec48e50450db6dcaf2e2c4::suifer {
    struct SUIFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFER>(arg0, 6, b"SUIFER", b"Suifer Coin Sui", b"SUIFER rides the waves of the Sui chain with the grace of a Shiba Inu on a surfboard! This token captures the spirit of adventure, blending the thrill of surfing with the playful energy of the Shiba Inu. As SUIFER glides across the crypto tides, it symbolizes both smooth sailing and the excitement of navigating dynamic markets. Get ready to surf the waves of Sui with SUIFERa token thats always riding the next big wave!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_22_37_48_ae0155c27f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

