module 0x6c762719ba4472760f37c0d389f1df40ed4ea146d63e70bbab7a16380aa951b6::suifu {
    struct SUIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFU>(arg0, 6, b"SUIFU", b"Sui Fu", b"Bringing to life the legendary story of a kung fu turtle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987592542.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

