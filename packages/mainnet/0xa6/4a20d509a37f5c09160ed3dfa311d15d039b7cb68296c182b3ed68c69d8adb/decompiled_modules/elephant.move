module 0xa64a20d509a37f5c09160ed3dfa311d15d039b7cb68296c182b3ed68c69d8adb::elephant {
    struct ELEPHANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPHANT>(arg0, 9, b"ELEPHANT", b"Blue Elephant", b"blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGs3EJZNgGJlPzHMqQGwNYlkNTJ2sUmyTxSA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELEPHANT>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPHANT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEPHANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

