module 0x544259ab740d355db6a8fddbc9a0889d57892c65bbdfcdadc612392285c89a0c::swt {
    struct SWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWT>(arg0, 6, b"SWT", b"SUI White Tiger", b"https://t.me/swtsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_22_50_16_58cd793c26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

