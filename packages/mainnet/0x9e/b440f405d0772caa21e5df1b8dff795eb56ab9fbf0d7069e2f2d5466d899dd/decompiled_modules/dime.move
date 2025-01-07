module 0x9eb440f405d0772caa21e5df1b8dff795eb56ab9fbf0d7069e2f2d5466d899dd::dime {
    struct DIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIME>(arg0, 9, b"DIME", b"Dime", b"Dime th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b458cb33-6ac6-40a0-8f3f-0249722946d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

