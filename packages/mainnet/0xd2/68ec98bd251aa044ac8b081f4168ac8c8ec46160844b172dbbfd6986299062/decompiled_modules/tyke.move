module 0xd268ec98bd251aa044ac8b081f4168ac8c8ec46160844b172dbbfd6986299062::tyke {
    struct TYKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYKE>(arg0, 6, b"TYKE", b"Type On Sui", b"Dexscreener Paid: https://www.tykeonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo1_8d61294e08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

