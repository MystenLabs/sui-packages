module 0x58b72d54fc2864709e97f7905759616bee302f0eb0f7f84b9ffab63bc08aaae::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"Pump", b"Putrump", b"The Ultimate Fusion of Power and Personality!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Warhead2017_Web_Final_dd8c84e0f8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

