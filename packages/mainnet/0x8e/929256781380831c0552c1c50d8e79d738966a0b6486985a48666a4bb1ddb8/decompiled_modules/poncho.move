module 0x8e929256781380831c0552c1c50d8e79d738966a0b6486985a48666a4bb1ddb8::poncho {
    struct PONCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONCHO>(arg0, 2, b"Poncho", b"Poncho", b"Poncho fair launch on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/36160/large/ponchologo.PNG?1710744293")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONCHO>(&mut v2, 30000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONCHO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

