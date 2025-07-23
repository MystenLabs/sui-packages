module 0x1a064b33a3056b14d33ee386ea1695d771b3c63eac2ad2c8385bf51ef54ef4b::ani {
    struct ANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANI>(arg0, 9, b"ANI", b"Animecoin", b"Animecoin was created for worldwide anime community by it's own members. I've chosen quark algorithm so that every anime fan could mine it using only CPU.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmWEVvnL4xpxpYmBNHfNJ11onQk6w7et2LjDgZ1Cwn41t8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

