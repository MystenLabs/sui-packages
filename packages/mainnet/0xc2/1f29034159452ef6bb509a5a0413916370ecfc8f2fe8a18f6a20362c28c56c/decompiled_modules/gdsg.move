module 0xc21f29034159452ef6bb509a5a0413916370ecfc8f2fe8a18f6a20362c28c56c::gdsg {
    struct GDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSG>(arg0, 9, b"GDSG", b"saf", b"DSCGBV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10d9c7ad-3970-4a01-a521-30322e99eeb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

