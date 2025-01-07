module 0x6a6328aa119cd285842092817cec55ba8d4677dd88df48fd928411176e187280::iekdbb {
    struct IEKDBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEKDBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEKDBB>(arg0, 9, b"IEKDBB", b"uekdn", b"bdbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/315f5bb6-a20b-4355-84cc-9267625df0e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEKDBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IEKDBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

