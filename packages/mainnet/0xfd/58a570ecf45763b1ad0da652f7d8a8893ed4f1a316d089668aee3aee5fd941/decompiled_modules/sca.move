module 0xfd58a570ecf45763b1ad0da652f7d8a8893ed4f1a316d089668aee3aee5fd941::sca {
    struct SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCA>(arg0, 6, b"SCA", b"SUIYAN CAT", b"The most annoying cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiyan_Cat_on_SUI_10_22_2024_11_54_PM_138ddb35f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

