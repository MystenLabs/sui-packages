module 0x76ebb09ea91b84013d9ff795e1428bc16c462439a4c03d064410a64e0a970542::robocat {
    struct ROBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOCAT>(arg0, 9, b"ROBOCAT", b"ROBO", b"Wake up ROBO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f977797-6fb3-41ae-bd7d-fed7017310fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

