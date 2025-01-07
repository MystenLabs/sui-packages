module 0x74de8a13ce8ea2abb307d40c55a885bad16551e5715adcf73eec3de623cea2af::sde {
    struct SDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDE>(arg0, 9, b"SDE", b"SuiDoge", b"First Doge-Memcoin on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tr.rbxcdn.com/6d5f79dd2ded531a22e21495c0f2e2d7/420/420/Image/Png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

