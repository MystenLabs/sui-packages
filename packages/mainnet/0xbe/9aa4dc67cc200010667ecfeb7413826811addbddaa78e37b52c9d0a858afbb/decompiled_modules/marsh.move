module 0xbe9aa4dc67cc200010667ecfeb7413826811addbddaa78e37b52c9d0a858afbb::marsh {
    struct MARSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSH>(arg0, 9, b"MARSH", b"Marsh Coin", b"Inspired by an orange walrus in a hoodie, crafted by artist Matt Furie. Built for those who love art, community, and a touch of fun. Join the movement and be part of something creative!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdExm1rmxegtWHYD94GhwEoJYqqM3U6EXV4bYJvUcUwLV")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARSH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

