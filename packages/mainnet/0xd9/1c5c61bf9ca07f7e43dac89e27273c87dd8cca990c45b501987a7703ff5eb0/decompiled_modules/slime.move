module 0xd91c5c61bf9ca07f7e43dac89e27273c87dd8cca990c45b501987a7703ff5eb0::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"SUI Slime", x"4d6565742024534c494d4520e280942074686520686170706965737420676c6f77696e6720626c756520626c6f622074686174206a75737420736c6964206f6e746f207468652053756920626c6f636b636861696e2e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789986079761.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

