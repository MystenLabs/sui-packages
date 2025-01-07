module 0x6cdfd1b842c3a14e94298c86de7321972f8554740db034e498ca6e373ecd554::mucbang {
    struct MUCBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUCBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUCBANG>(arg0, 9, b"MUCBANG", b"Muc Bang", b"Muc Bang - Muc Bang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c273131-4302-40b2-94fc-c5bb2ed4d0a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUCBANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUCBANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

