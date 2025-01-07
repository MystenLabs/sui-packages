module 0xce51683719d2f8063ba2ca2e35d0afacfa9064d1e83549d41128151710a3a81c::ln {
    struct LN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LN>(arg0, 9, b"LN", b"Le Nin", b"Lenin UG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aee1bab6-c57f-4230-b74f-c0dec25879ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LN>>(v1);
    }

    // decompiled from Move bytecode v6
}

