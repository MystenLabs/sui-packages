module 0x8cdc1c7bc8aab650304f0d706c091d52577a53883c0ca4f31a8670b9462ec2e0::suibot {
    struct SUIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOT>(arg0, 6, b"SuiBot", b"sui sbot", b"Sui network sniper bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002174_63f1328aea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

