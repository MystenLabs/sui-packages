module 0x9358f7285944a5d01169cc8f3fdbfc03045e5087cbbbce164f7f53b88797f3b9::oend {
    struct OEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEND>(arg0, 9, b"OEND", b"uejd", b"jdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/155e2521-5a98-48a2-8309-e957da676a7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

