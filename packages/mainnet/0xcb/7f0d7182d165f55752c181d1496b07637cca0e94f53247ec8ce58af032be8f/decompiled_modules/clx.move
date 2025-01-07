module 0xcb7f0d7182d165f55752c181d1496b07637cca0e94f53247ec8ce58af032be8f::clx {
    struct CLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLX>(arg0, 9, b"CLX", b"Calux", b"Trade For Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f95349d-b957-4660-95a2-098125ee59b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

