module 0xcfa1a025c5261d36562f573854878cb16fb16fa8278b85f424d3751db31cb291::saint {
    struct SAINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAINT>(arg0, 9, b"SAINT", b"Franklin", b"Snowfall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/137dea97-9fe1-4a93-8a67-1d66eae64873-1000001962.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

