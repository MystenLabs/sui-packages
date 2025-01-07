module 0xf9dedc0779b316a72a21a1efb2ae21c04c2251ab8b19ad6f993eb7a5cd09074e::csx {
    struct CSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSX>(arg0, 9, b"CSX", b"EW", b"CVXZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d8a486c-c450-4309-be17-e296a379a325.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

