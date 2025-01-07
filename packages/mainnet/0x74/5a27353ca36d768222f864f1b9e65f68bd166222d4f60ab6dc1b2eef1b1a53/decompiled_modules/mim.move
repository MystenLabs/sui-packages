module 0x745a27353ca36d768222f864f1b9e65f68bd166222d4f60ab6dc1b2eef1b1a53::mim {
    struct MIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIM>(arg0, 9, b"MIM", b"mimi", b"The reflective cryptocurrency that's mimicking market moves to deliver gains that are a spitting image of success :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44873ddc-8086-4a0e-a8d8-40f1c14fedf8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

