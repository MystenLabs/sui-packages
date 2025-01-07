module 0x3517d7415f957a366ae48209fc8a393b05ba39511b686154ef49f84344404f0e::lnrd {
    struct LNRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNRD>(arg0, 9, b"LNRD", b"Lana Rhoad", b"Every Crypto Investor's Wet Dream. Long-lasting and profitable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea99e570-68f3-44ed-ae58-bdcc64a9333b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LNRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

