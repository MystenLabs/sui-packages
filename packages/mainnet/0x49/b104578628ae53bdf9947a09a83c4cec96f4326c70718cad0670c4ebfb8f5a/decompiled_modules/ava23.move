module 0x49b104578628ae53bdf9947a09a83c4cec96f4326c70718cad0670c4ebfb8f5a::ava23 {
    struct AVA23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVA23, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVA23>(arg0, 9, b"AVA23", b"124", b"125", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e429872-8e1c-4f06-a232-25c7b910a3b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVA23>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVA23>>(v1);
    }

    // decompiled from Move bytecode v6
}

