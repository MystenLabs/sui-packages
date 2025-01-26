module 0x805287061d75241396abacde7f8e6b47fd713d0816dd9fc3bb63dcac795adb9c::sand {
    struct SAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAND>(arg0, 6, b"SAND", b"Sandy Cheeks Official Mascot on SUI by SuiAI", b"The Cutest Mascot on SUI and SUIAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sandy_cheeks_f2d24d5899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAND>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAND>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

