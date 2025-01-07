module 0x589c9c742a2496ce3418bd71191c8bfbf53eaeb92cab060168bb6fb181128720::s66767 {
    struct S66767 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S66767, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S66767>(arg0, 9, b"S66767", b"vcvbgh", b"dfsdfdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/532f187d-c26c-4a20-aca4-155b5ad0a583.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S66767>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S66767>>(v1);
    }

    // decompiled from Move bytecode v6
}

