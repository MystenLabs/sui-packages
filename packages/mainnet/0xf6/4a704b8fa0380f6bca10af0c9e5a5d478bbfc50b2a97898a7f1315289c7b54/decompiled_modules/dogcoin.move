module 0xf64a704b8fa0380f6bca10af0c9e5a5d478bbfc50b2a97898a7f1315289c7b54::dogcoin {
    struct DOGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGCOIN>(arg0, 9, b"DOGCOIN", b"DOGCOIN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/04/8b/8d/048b8dbc061a104f266176b1b7bf828c.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGCOIN>>(v1);
        0x2::coin::mint_and_transfer<DOGCOIN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGCOIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

