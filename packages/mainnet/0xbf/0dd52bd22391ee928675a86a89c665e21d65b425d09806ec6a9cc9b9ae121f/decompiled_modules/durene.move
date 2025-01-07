module 0xbf0dd52bd22391ee928675a86a89c665e21d65b425d09806ec6a9cc9b9ae121f::durene {
    struct DURENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DURENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DURENE>(arg0, 6, b"DURENE", b"Tropical AIrene", b"WAGMI. LFG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731635725756.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DURENE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DURENE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

