module 0xacf8f23550564ef722fb5e4d51398eac41d96cb70e1e3332d4052754259d9a7a::niki {
    struct NIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKI>(arg0, 9, b"NIKI", b"NikiCoin", b"A token called NikiCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NIKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

