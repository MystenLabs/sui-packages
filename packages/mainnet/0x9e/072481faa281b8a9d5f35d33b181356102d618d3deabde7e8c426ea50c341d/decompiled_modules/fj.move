module 0x9e072481faa281b8a9d5f35d33b181356102d618d3deabde7e8c426ea50c341d::fj {
    struct FJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FJ>(arg0, 9, b"FJ", b"KU", b"F", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23ef7191-6cb4-47e1-a8b2-dad87efa5616.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

