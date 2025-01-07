module 0x9db97a42ac7811c00351a2b11cb6054496df9e491ff42e54d7ce894303895038::mostofa69 {
    struct MOSTOFA69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSTOFA69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSTOFA69>(arg0, 9, b"MOSTOFA69", b"MOSTOFA T", b"Ok, I Am Simple ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f8770b0-9d22-4424-b8ca-a2587772c079.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSTOFA69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSTOFA69>>(v1);
    }

    // decompiled from Move bytecode v6
}

