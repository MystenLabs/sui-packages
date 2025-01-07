module 0xa13482e775696166af91c43ad4e431c81c21c329270c0b6e887ccc4cb3b9d9e8::suidepin {
    struct SUIDEPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEPIN>(arg0, 6, b"SUIDEPIN", b"SUIDEPIN AI", b"The First DEPIN Layer on SUI that enables billions of devices to securely transact and monetize their Data", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735894100823.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDEPIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEPIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

