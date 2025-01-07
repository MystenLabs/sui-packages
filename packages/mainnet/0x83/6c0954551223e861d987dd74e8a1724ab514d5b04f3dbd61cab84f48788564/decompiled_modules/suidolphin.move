module 0x836c0954551223e861d987dd74e8a1724ab514d5b04f3dbd61cab84f48788564::suidolphin {
    struct SUIDOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOLPHIN>(arg0, 6, b"SUIDolphin", b"SUI Dolphin", b"Sui Dolphin, an ecological guardian of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_Dolphin_22bf7553c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

