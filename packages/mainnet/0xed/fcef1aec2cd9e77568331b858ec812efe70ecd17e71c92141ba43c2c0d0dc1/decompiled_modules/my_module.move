module 0xedfcef1aec2cd9e77568331b858ec812efe70ecd17e71c92141ba43c2c0d0dc1::my_module {
    struct MY_MODULE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_MODULE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_MODULE>(arg0, 6, b"HESOLD", b"Christmas Pumper", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/G4ohVY5KmpsLeiD4bcJ7kfNKfpLYNzvf6owoh4k6pump.png?size=xl&key=69450e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MY_MODULE>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_MODULE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_MODULE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

