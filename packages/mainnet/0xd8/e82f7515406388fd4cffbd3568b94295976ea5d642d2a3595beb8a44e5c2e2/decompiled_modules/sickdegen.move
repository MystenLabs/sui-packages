module 0xd8e82f7515406388fd4cffbd3568b94295976ea5d642d2a3595beb8a44e5c2e2::sickdegen {
    struct SICKDEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICKDEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICKDEGEN>(arg0, 9, b"SICKDEGEN", b"Degenerate", b"Sick degenerate ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73dd4312-f931-4b3f-af31-5b54e628ef3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICKDEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SICKDEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

