module 0x82f6153c46bd5d46a018b1f971f019e33952646bd58085facbd2fc170543f89e::OPUT {
    struct OPUT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPUT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<OPUT>(arg0) + arg1 <= 1000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<OPUT>>(0x2::coin::mint<OPUT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: OPUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPUT>(arg0, 6, b"OPUT", b"OPUT", b"OPUT Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/okb.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OPUT>>(0x2::coin::mint<OPUT>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPUT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OPUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

