module 0xaca329d0f44cb7ecddde270440b921a275b31f852598f20ae1764df934cc34e6::lgbt {
    struct LGBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGBT>(arg0, 9, b"LGBT", b"LGBT", b"Let's fucking go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Gay_Pride_Flag.svg/262px-Gay_Pride_Flag.svg.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGBT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LGBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGBT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

