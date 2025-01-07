module 0xc00d881b6c9467e67e2028b87c3a08c1b0990d49799023c80e0c0eb4caffb98c::antarctica {
    struct ANTARCTICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTARCTICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTARCTICA>(arg0, 2, b"Antarctica", b"Antarctica", b"Antarctica will be FREE. Antarctica will WIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANTARCTICA>(&mut v2, 333333333333333300, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTARCTICA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTARCTICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

