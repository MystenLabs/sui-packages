module 0xa9120eaa9ea95bba8fc09a9b13ae21ba279eb113f42f21bbf1f35e91d485f1a3::dln {
    struct DLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLN>(arg0, 9, b"DLN", b"DollarLion", b"A big lion Made by Billion of dollar. Each part of his body is a real dollar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c762fb2-cea3-4c53-a614-817e94d2fdc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

