module 0xc0fecca9963d66367be945632b8208b36a9b164e90dc54ef6d18f88a55be4a5d::IMG {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IMG>>(v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<IMG>, 0x2::coin::CoinMetadata<IMG>) {
        let (v0, v1) = 0x2::coin::create_currency<IMG>(arg0, 9, b"TSTK", b"Test Token", b"Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/flying-bird-sparrow-isolated-white-background-house-transparent-png-272795544.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IMG>(&mut v2, 1000000000000000000, @0xf6cf5bc0310cde362076f8cf3e51014ff1e977071c3a15e2668d3146e7d447d4, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

