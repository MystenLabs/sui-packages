module 0x71160a447b986a1379c853a2b22a81e8bd02129297b15aa2e79d0387dc71bd5a::chady {
    struct CHADY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHADY>, arg1: 0x2::coin::Coin<CHADY>) {
        0x2::coin::burn<CHADY>(arg0, arg1);
    }

    fun init(arg0: CHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADY>(arg0, 9, b"CHADY", b"Chady", b"Chady", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUYAFZcDYyfH45p6KX4wjWKraGQSJRP4juvqXh6ipxLTp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHADY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHADY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

