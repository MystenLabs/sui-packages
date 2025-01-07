module 0xc2674516c9289edb8ff18be2d5ba9712c53f82aa1782bec1f1e99ea61adb0242::fjoker {
    struct FJOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FJOKER>(arg0, 6, b"FJOKER", b"Fun Joker", b"Dexscreener paid.Check here: https://www.jokeronsui.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_5_714ba9b628.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FJOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FJOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

