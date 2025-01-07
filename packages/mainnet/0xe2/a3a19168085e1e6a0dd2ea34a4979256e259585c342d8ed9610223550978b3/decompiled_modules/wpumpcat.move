module 0xe2a3a19168085e1e6a0dd2ea34a4979256e259585c342d8ed9610223550978b3::wpumpcat {
    struct WPUMPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPUMPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPUMPCAT>(arg0, 9, b"WPUMPCAT", b"Wewepcat", b"Reliable ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad4df983-93ff-44a1-92de-ecde7c6bdbee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPUMPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPUMPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

