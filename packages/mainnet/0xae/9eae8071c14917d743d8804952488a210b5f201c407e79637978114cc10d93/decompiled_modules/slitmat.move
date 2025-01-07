module 0xae9eae8071c14917d743d8804952488a210b5f201c407e79637978114cc10d93::slitmat {
    struct SLITMAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLITMAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLITMAT>(arg0, 9, b"SLITMAT", b"Splitmata", b"Kacamata dong bang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ebb406d-ef24-4dbe-81d9-5b1d0637c0f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLITMAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLITMAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

