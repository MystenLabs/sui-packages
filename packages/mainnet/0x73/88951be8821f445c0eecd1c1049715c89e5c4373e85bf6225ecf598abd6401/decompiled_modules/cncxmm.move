module 0x7388951be8821f445c0eecd1c1049715c89e5c4373e85bf6225ecf598abd6401::cncxmm {
    struct CNCXMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNCXMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNCXMM>(arg0, 9, b"CNCXMM", b"Kdhsmzm", b"Shdmmdmf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7005ce98-8273-4a4e-b2f4-79d6f04689f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNCXMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNCXMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

