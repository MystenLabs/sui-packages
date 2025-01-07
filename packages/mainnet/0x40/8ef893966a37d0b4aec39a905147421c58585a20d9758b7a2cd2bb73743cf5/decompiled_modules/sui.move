module 0x408ef893966a37d0b4aec39a905147421c58585a20d9758b7a2cd2bb73743cf5::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"Sui v2 (migrate: suiv2.com)", b"complete bride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/5bd0f43855f6434386c59f2341c5aaf0.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI>(&mut v2, 3000000000 * 0x1::u64::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

