module 0x91ffa70751687be0126fbb328646ab78f60f3395eefbc5b6a06a979b4a422e5b::svtjr {
    struct SVTJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVTJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVTJR>(arg0, 9, b"SVTjr", b"SVTjr", b"SVTjrs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SVTJR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVTJR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVTJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

