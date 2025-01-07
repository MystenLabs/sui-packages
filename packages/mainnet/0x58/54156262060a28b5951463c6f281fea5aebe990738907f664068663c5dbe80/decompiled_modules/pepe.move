module 0x5854156262060a28b5951463c6f281fea5aebe990738907f664068663c5dbe80::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE", b"PepePenny", b"A meme coin featuring Pepe the Frog, designed for small-scale investors with the slogan \"Every penny counts!\" Its mascot is Pepe holding a tiny gold coin, symbolizing small steps toward big gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2d16068-4e85-4387-8f3b-7d3130832756.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

