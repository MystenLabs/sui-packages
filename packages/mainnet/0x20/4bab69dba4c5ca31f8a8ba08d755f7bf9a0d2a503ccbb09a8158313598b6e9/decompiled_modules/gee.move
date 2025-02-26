module 0x204bab69dba4c5ca31f8a8ba08d755f7bf9a0d2a503ccbb09a8158313598b6e9::gee {
    struct GEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEE>(arg0, 9, b"GEE", b"Gee Token", b"A token for the GEE community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

