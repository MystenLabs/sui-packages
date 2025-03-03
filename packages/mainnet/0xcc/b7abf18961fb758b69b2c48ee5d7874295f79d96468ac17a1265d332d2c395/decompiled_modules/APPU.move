module 0xccb7abf18961fb758b69b2c48ee5d7874295f79d96468ac17a1265d332d2c395::APPU {
    struct APPU has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APPU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<APPU>(arg0) + arg1 <= 1000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<APPU>>(0x2::coin::mint<APPU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: APPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPU>(arg0, 6, b"APPU", b"APPU", b"APPU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/appcoins.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<APPU>>(0x2::coin::mint<APPU>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPU>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APPU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

