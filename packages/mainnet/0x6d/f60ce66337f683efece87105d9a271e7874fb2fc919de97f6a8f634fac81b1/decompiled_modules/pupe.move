module 0x6df60ce66337f683efece87105d9a271e7874fb2fc919de97f6a8f634fac81b1::pupe {
    struct PUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPE>(arg0, 9, b"PUPE", b"Punch pepe", b"Pepe want to punch you to make you strong in the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5ea648c-4143-4aab-8260-441b83a04a8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

