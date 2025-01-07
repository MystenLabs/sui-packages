module 0x19008197e581fc9d1b1558d8322efcc4e47070292c23aa587c0b5e9321c370ac::dgsg {
    struct DGSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSG>(arg0, 9, b"DGSG", x"445347c4906668", x"c3804753474453", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d20033b8-3c24-4384-b8e7-e684a2d85edb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

