module 0xc9c7eed2cbec8bc4aa42785eb95891742d380450032a07c4dcd75844f0df29aa::doo {
    struct DOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOO>(arg0, 9, b"DOO", b"Baby-Doo", b"Baby Doo is known as a dog who loves adventure and has a great fondness for water. He often explores the underwater world to discover its beauty and make new friends. With his funny and energetic personality, Baby Doo is adored by all the sea creatures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5d26c28-6d7b-4220-8900-8eeb65b740e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

