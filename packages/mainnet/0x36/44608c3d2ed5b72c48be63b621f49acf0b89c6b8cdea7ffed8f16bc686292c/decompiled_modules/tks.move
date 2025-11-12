module 0x3644608c3d2ed5b72c48be63b621f49acf0b89c6b8cdea7ffed8f16bc686292c::tks {
    struct TKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKS>(arg0, 6, b"TKS", b"thankyou", b"123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1762921014859.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

