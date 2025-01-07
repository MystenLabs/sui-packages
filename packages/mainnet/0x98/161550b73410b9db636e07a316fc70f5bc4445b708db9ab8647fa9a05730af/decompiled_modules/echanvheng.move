module 0x98161550b73410b9db636e07a316fc70f5bc4445b708db9ab8647fa9a05730af::echanvheng {
    struct ECHANVHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHANVHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHANVHENG>(arg0, 7, b"ECHANVHENG", b"ECHAN VHENG", b"Vheng for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ECHANVHENG>(&mut v2, 15000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHANVHENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECHANVHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

