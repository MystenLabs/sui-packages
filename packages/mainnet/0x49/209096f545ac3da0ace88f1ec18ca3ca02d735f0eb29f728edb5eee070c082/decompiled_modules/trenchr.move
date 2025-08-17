module 0x49209096f545ac3da0ace88f1ec18ca3ca02d735f0eb29f728edb5eee070c082::trenchr {
    struct TRENCHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHR>(arg0, 9, b"TRENCHR", b"TRENCHR", b"TRENCH FIGHTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRENCHR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHR>>(v2, @0x7cce362f37078ad81612c36808ec1e4e373ddac3d506dadeb2beaef6d7efe9fe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

