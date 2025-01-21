module 0x80eb6c9e6b4caf9a939a13cebd117639806cb8f3a0aa3a600ef22f0e6f6a2b94::vzxczxv {
    struct VZXCZXV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VZXCZXV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VZXCZXV>(arg0, 6, b"VZXCZXV", b"XVzxc by SuiAI", b"zxczxv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/fn_Oe_R_Dv7_400x400_2eba5abf57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VZXCZXV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VZXCZXV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

