module 0xa2a08f8aa2f291239fc751c05a392bea74d0d7dde5a49785ab63de3379687db7::bkm {
    struct BKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKM>(arg0, 6, b"BKM", b"Bakemen", b"Bakeman Coin, a groundbreaking cryptocurrency, has established strong connections with Solana, Sui, and Supra Project, enhancing its capabilities, scalability, and usability, positioning it as a leading DeFi player.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732986754897.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

