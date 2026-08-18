module 0xabb890a815a827fac614e862652a49f83dfb56db39407bc78b004bda029e3174::wefw {
    struct WEFW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEFW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEFW>(arg0, 6, b"WEFW", b"wefwe", b"wef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEFW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEFW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

