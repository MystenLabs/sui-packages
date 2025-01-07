module 0xcb1774a570c105f35aadc2dd9a5d7891dbeeb0461ae1bd798989e3b5414f0f96::clt {
    struct CLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLT>(arg0, 9, b"CLT", b"Chalvat ", b"A token for jokes and laughter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85a89c3d-ce82-4fa7-a3e4-26c3f66cec70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

