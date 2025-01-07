module 0x5ec5f53c27688c7c72ca9020aaedb9460d877804108aa9014e4d775fb8a38277::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOA>(arg0, 9, b"KOA", b"Koala", b"Koala is cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0777498d-2165-4dca-8373-a19ebeb49c21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

