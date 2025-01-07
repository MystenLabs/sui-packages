module 0x69912d8cbda3e24a08394a6e2cbef24d0b76eb86e2974df7e0b927a78a29d49c::hc {
    struct HC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HC>(arg0, 9, b"HC", b"HrenCoin", b"A coin provided with horseradish. The real RWA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b421fc6-bd47-414e-a245-a751a7f7c42e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HC>>(v1);
    }

    // decompiled from Move bytecode v6
}

