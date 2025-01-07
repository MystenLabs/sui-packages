module 0xe730754cf051a982092ce1dbea5aabf3a89d9de80dd5d7e218772c82a5fbb8b3::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JERRY>, arg1: 0x2::coin::Coin<JERRY>) {
        0x2::coin::burn<JERRY>(arg0, arg1);
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 9, b"JERRY", b"JerryOnSui", b"https://t.me/jerryonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/47Sdk7S/JERRY.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JERRY>>(v1);
        0x2::coin::mint_and_transfer<JERRY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

