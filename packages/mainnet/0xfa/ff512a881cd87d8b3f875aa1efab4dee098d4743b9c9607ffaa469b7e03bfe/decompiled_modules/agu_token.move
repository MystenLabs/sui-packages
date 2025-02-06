module 0xfaff512a881cd87d8b3f875aa1efab4dee098d4743b9c9607ffaa469b7e03bfe::agu_token {
    struct AGU_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGU_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<AGU_TOKEN>(arg0) + arg1 <= 1000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGU_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGU_TOKEN>(arg0, 6, b"ceshi6", b"ceshi666", b"AGU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://statics.solscan.io/cdn/imgs/s60?ref=68747470733a2f2f7374617469632e6a75702e61672f6a75702f69636f6e2e706e67")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGU_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGU_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

