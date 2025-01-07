module 0xd47ef3f5f7e1ffed51b55ac43f3ca1dd9dbcc3c3d1990be0ad0051c254dc2765::shk {
    struct SHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHK>(arg0, 9, b"SHK", b"Meme Shark", b"Om vip ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f0afc21-cdbf-463f-9414-ccb61f4604e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

