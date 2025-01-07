module 0xd91d6b1c5781566f5340229ea160b0dd48e9419c6aad63f3085d8760e1de4001::bbdog {
    struct BBDOG has drop {
        dummy_field: bool,
    }

    public fun get_icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://ibb.co/hYy9NCL")
    }

    fun init(arg0: BBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBDOG>(arg0, 2, b"BBDOG", b"Baby dog", b"Baby dog!", 0x1::option::some<0x2::url::Url>(get_icon_url()), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BBDOG>>(0x2::coin::mint<BBDOG>(&mut v2, 80000000000000000 * pow(10, 2), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBDOG>>(v2, 0x2::tx_context::sender(arg1));
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

