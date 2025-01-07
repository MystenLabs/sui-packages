module 0x5370df7e07a48fd3c9f849c13fb0e4a421a636bd32c489aeb5a4772d06de0521::evil_empires {
    struct EVIL_EMPIRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVIL_EMPIRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVIL_EMPIRES>(arg0, 0, b"Evil Empires Founding Token", b"EE", b"Token distributed to founders at the very start of Evil Empires.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVIL_EMPIRES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<EVIL_EMPIRES>>(0x2::coin::mint<EVIL_EMPIRES>(&mut v2, 1000000, arg1), @0xfbb492d5288a408c139e6fbf51d3c6b7d9bd4eb239711e08668bb0357e6c382d);
        0x2::transfer::public_transfer<0x2::coin::Coin<EVIL_EMPIRES>>(0x2::coin::mint<EVIL_EMPIRES>(&mut v2, 1000000, arg1), @0x2a1410947ff8f188e84af32bb9ae5ea441bf902abb5289df6f51ffbe4dae1570);
        0x2::transfer::public_transfer<0x2::coin::Coin<EVIL_EMPIRES>>(0x2::coin::mint<EVIL_EMPIRES>(&mut v2, 1000000, arg1), @0x8b0ba28663486af33d262cb566cabbb9eaa735b9b979c5d1397b4e731d1fd001);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVIL_EMPIRES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

