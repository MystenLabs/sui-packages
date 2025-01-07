module 0x65361f9fb82ac8a38e9043c67b995cf3fc30eb5ec2ac9ea5a8fa743a51a43d80::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NS>(arg0, 9, b"NS", b"NOT SUI", b"Create coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NS>(&mut v2, 210000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NS>>(v1);
    }

    // decompiled from Move bytecode v6
}

