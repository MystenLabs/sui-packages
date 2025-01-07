module 0x7c35a625834bf563ad265b9d5dd75069649d05d961ca5d2896738627a72d8916::bronzo {
    struct BRONZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRONZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRONZO>(arg0, 10, b"BRONZO", b"BRONZO", b"BRONZO is a dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRONZO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRONZO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRONZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

