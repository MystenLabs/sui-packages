module 0x1d056f9ce75aa838a4df1cdac535c188f82925fda2c01d7f3447aaf247e5a87c::bdd20 {
    struct BDD20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDD20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDD20>(arg0, 9, b"BDD20", b"Bigdady", b"Sui Tsunami Fun mem coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2c8540a-30ae-4bfd-af5c-2b1031894c92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDD20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDD20>>(v1);
    }

    // decompiled from Move bytecode v6
}

