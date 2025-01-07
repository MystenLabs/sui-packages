module 0xad994dfee0bb76cfbc106c39fe29f457fa2e4f3709c3adb44f95bc673058cab8::bruh {
    struct BRUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUH>(arg0, 6, b"Bruh", b"JUST BRUH", x"596f7520736572696f7573207269676874206e6f773f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6946c18f4eaff25e7c89d97714f3b939_70658cffd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

