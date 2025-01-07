module 0xabeaf90af886b205a182a9510dac4da7833b7e2a83a703a71bd2182aabda3008::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 2, b"TEST", b"Just for test!", b"Just for test, don't buy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/s21Mp30/2609f4e62abee443b75ecf78061e5ffd.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TT>>(0x2::coin::mint<TT>(&mut v2, 10000000000000 * pow(10, 2), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = 1;
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = v0 * arg0;
            };
            arg1 = arg1 / 2;
            arg0 = arg0 * arg0;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

