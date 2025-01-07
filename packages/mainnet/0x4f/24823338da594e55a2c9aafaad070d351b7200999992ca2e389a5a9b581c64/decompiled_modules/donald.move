module 0x4f24823338da594e55a2c9aafaad070d351b7200999992ca2e389a5a9b581c64::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD>(arg0, 6, b"DONALD", b"DONALD on SUI", b"By the people, for the people! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k9tnjbxo_400x400_2bfe3fc990.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

