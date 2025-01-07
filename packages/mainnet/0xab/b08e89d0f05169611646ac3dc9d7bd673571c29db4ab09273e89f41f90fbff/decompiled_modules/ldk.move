module 0xabb08e89d0f05169611646ac3dc9d7bd673571c29db4ab09273e89f41f90fbff::ldk {
    struct LDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDK>(arg0, 9, b"LDK", b"Landak", b"Landak Berduri", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d025aed-475b-4271-bdf7-62e175442540.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

