module 0x595d060151d823ff74d90c44f63e05c3b512abbf578f5e35b1821091da987fd4::eki {
    struct EKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKI>(arg0, 9, b"EKI", b"Ekinadose", b"Oweioba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94672aee-7d05-4d4f-81f9-3ec9c8fc9a34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

