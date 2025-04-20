module 0xad74b5c5c39fe57409d80151ae47cf092c7a5fa3b9e8dc1a171e16cda2fcab7c::usft {
    struct USFT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USFT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<USFT>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USFT>>(0x2::coin::mint<USFT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USFT>(arg0, 6, b"USFT", b"USFT", b"USFT Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.coinall.ltd/cdn/wallet/logo/USFT-20220308.png?x-oss-process=image/format,webp/ignore-error,1")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USFT>>(0x2::coin::mint<USFT>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

