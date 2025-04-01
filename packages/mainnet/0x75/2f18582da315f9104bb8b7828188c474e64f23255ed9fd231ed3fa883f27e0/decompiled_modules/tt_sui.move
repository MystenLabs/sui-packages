module 0x752f18582da315f9104bb8b7828188c474e64f23255ed9fd231ed3fa883f27e0::tt_sui {
    struct TT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT_SUI>(arg0, 9, b"tSUI", b"TEST SUI", b"te", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"temp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

