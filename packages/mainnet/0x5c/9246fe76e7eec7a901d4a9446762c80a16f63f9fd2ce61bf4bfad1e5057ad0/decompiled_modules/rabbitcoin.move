module 0x5c9246fe76e7eec7a901d4a9446762c80a16f63f9fd2ce61bf4bfad1e5057ad0::rabbitcoin {
    struct RABBITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBITCOIN>(arg0, 6, b"RabBitcoin", b"Rocky Rabbit", b"Step into the world of Rocky Rabbit, where you transform from a rookie to a grandmaster in the crypto gaming arena and where Crypto Gaming Meets Strategy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723380054142_dc5d3f813e5ef2a4fced089c128c76d7_ac427c80a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABBITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

