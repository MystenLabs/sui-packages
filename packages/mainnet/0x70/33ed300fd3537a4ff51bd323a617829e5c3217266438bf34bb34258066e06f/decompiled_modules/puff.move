module 0x7033ed300fd3537a4ff51bd323a617829e5c3217266438bf34bb34258066e06f::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"SuiDiddy", b"In the vibrant world of Autistic  Diddy, every day is an adventure filled with joy and friendship. Whether he's exploring new ideas or bringing smiles to those around him, Diddy's journey is a testament to the power of kindness and inclusivity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_04_22_21_38_e1de172bcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

