module 0x4e97f9299cf8b5cd366655705441f68f9fab5ed12806d4e95328ac53d0f835dc::suikibidicat {
    struct SUIKIBIDICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIBIDICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIBIDICAT>(arg0, 6, b"SUIKIBIDICAT", b"SUIKIBIDI CAT", b"SKIBIDI CAT ON SUI TELEGRAM @skibidicatsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_EA_4_E201_04_DA_4_B0_B_AD_75_0603_A6_EFB_370_ef1ad845ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIBIDICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKIBIDICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

