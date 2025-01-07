module 0x7ca2f763844216f50d478bee48dab9dab2c945287937d153166ea90cc6444f88::kzmch {
    struct KZMCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KZMCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KZMCH>(arg0, 9, b"KZMCH", b"Kuzmich", b"Coin for my dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d1e51b5-97f9-479a-9c10-95821d915b83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KZMCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KZMCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

