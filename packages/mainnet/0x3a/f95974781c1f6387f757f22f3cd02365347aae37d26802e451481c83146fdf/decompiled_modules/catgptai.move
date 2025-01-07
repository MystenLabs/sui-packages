module 0x3af95974781c1f6387f757f22f3cd02365347aae37d26802e451481c83146fdf::catgptai {
    struct CATGPTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATGPTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGPTAI>(arg0, 6, b"CATGPTAI", b"Cat GPT AI", b"First Cat GPT AI on Sui Chain Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_04_at_10_26_20a_PM_fa42e8c7fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGPTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATGPTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

