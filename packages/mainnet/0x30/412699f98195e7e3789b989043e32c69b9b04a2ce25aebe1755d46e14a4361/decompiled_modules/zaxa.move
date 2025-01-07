module 0x30412699f98195e7e3789b989043e32c69b9b04a2ce25aebe1755d46e14a4361::zaxa {
    struct ZAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAXA>(arg0, 9, b"ZAXA", b"ZAXA VAU", b"TEAM WORK IS THE KEY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da83bcdb-5d26-45f2-bf1f-4d686070adf8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

