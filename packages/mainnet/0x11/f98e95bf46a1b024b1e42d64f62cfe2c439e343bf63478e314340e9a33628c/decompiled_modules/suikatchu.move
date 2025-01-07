module 0x11f98e95bf46a1b024b1e42d64f62cfe2c439e343bf63478e314340e9a33628c::suikatchu {
    struct SUIKATCHU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIKATCHU>, arg1: 0x2::coin::Coin<SUIKATCHU>) {
        0x2::coin::burn<SUIKATCHU>(arg0, arg1);
    }

    fun init(arg0: SUIKATCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKATCHU>(arg0, 9, b"suikatchu", b"$SUICHU", b"Suikatchu the famous Pokemon on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/d5kBX3r.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKATCHU>>(v1);
        0x2::coin::mint_and_transfer<SUIKATCHU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKATCHU>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIKATCHU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIKATCHU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

