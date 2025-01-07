module 0x4589ac0af4fd9948584aaeef36064a582c1684c8ca1904c0ea7b8925c414064a::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 9, b"PLOP", b"PLOP", b"plop on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLOP>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

