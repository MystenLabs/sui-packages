module 0xd051b189b9b5ff3e8612a6add718fddead12083bd488bf883783f8f401c1105d::suiiiiiiiiii {
    struct SUIIIIIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIIIIIII>(arg0, 6, b"SUIIIIIIIIII", b"ISuiSpeed", b":0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://isuispeed.fun/images/logo-header.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIIIIIIIIII>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIIIIIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

