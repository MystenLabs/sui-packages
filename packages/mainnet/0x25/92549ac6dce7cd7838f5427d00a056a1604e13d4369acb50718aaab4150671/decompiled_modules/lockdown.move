module 0x2592549ac6dce7cd7838f5427d00a056a1604e13d4369acb50718aaab4150671::lockdown {
    struct LOCKDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOCKDOWN>(arg0, 6, b"LOCKDOWN", b"Lockdown by SuiAI", b"Transformed Mode: In vehicle mode, Lockdown becomes a sleek, black and silver 2013 Pagani Huayra, embodying an aura of speed and stealth. .Robot Mode: His robot form is distinct with a menacing appearance. He has a muscular, angular build with numerous weapons integrated into his design. .Notable Features: .Single Red Eye: His face is partially obscured, with one large, glowing red eye that adds to his intimidating look..Hook Hand: His right hand is a large, retractable hook which he uses both as a weapon and for capturing his targets..Arm Cannon and Blades: He's equipped with various types of weaponry, including an arm cannon and extendable blades, enhancing his combat capabilities..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_2bf75b77e5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOCKDOWN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKDOWN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

