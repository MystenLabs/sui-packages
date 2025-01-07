module 0x3a1b632f5661064ea027eae47958078b93a96a11fbb1e86f8d4659cb41823c87::trld {
    struct TRLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRLD>(arg0, 9, b"TRLD", b"TRUELADY", b"A TRUE LADY , A TRUE TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4eb0c2e-d634-4003-a52f-db095940500e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

