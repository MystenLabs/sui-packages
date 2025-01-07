module 0x51da543a95ebacdcfb4a205144bb743f84308433d18b2ce0f60dc218ddfce5e7::cnf {
    struct CNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNF>(arg0, 9, b"CNF", b"Confirmed ", b"The CNF Token is a digital cryptocurrency that serves as a native utility token within the CNF blockchain ecosystem. It is used primarily ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/263e5e7d-3856-43e5-8772-c4e872943038.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNF>>(v1);
    }

    // decompiled from Move bytecode v6
}

