module 0x2636fe42cb94420b71fdf27d2e511aa66eeef6545a335af2675bfc6a5d549279::psai {
    struct PSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSAI>(arg0, 6, b"PSAI", b"Poseidon AI", b"Poseidon \"God of the Sea\" AI rules SUI waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736093162259.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

