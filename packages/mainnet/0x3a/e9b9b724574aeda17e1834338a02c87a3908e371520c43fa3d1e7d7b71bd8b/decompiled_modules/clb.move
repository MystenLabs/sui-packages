module 0x3ae9b9b724574aeda17e1834338a02c87a3908e371520c43fa3d1e7d7b71bd8b::clb {
    struct CLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLB>(arg0, 9, b"CLB", b"Clurb", b"Clurb is a meme coin for party lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d530b13-dca4-4574-9ea5-1a9cfd8d4b65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

