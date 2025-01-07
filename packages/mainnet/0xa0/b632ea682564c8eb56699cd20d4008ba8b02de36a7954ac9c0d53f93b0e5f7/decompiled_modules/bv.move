module 0xa0b632ea682564c8eb56699cd20d4008ba8b02de36a7954ac9c0d53f93b0e5f7::bv {
    struct BV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BV>(arg0, 9, b"BV", b"HT", b"XVC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/958fff38-7e61-4044-baf6-765da72d027c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BV>>(v1);
    }

    // decompiled from Move bytecode v6
}

