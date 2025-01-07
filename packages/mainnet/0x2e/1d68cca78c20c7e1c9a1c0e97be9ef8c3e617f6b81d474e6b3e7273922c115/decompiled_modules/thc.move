module 0x2e1d68cca78c20c7e1c9a1c0e97be9ef8c3e617f6b81d474e6b3e7273922c115::thc {
    struct THC has drop {
        dummy_field: bool,
    }

    fun init(arg0: THC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THC>(arg0, 9, b"THC", b"T.H.C", b"if you love thc formula you will love it's coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc6eb365-c65e-42bd-8709-38d7cc0eb335.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THC>>(v1);
    }

    // decompiled from Move bytecode v6
}

