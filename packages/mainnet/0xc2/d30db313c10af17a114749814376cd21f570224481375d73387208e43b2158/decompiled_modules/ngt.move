module 0xc2d30db313c10af17a114749814376cd21f570224481375d73387208e43b2158::ngt {
    struct NGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGT>(arg0, 9, b"NGT", b"SJP", b"Good morning I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e11a9a5c-da40-4c51-8d22-ddd10229e139.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

