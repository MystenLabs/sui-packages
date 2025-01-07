module 0x55452bb4a6d7e93fb0c727a951869eb444dd4ae22348a5f3ab9d7e2805d7eeea::caysui {
    struct CAYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAYSUI>(arg0, 6, b"CAYSUI", b"Claysui", b"The fluffiest mascot of the SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6h_Uqld_VH_400x400_34042b2c88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

