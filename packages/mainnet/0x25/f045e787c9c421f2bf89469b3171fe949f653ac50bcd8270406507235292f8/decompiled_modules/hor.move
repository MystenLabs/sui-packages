module 0x25f045e787c9c421f2bf89469b3171fe949f653ac50bcd8270406507235292f8::hor {
    struct HOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOR>(arg0, 9, b"HOR", b"HORROR SHI", b"Horror Shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbee1b35-43b9-4c6f-8b43-ef3a7aa7b2bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

