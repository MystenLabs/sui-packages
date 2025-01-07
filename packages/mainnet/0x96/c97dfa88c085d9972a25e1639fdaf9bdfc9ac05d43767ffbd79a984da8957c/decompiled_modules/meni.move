module 0x96c97dfa88c085d9972a25e1639fdaf9bdfc9ac05d43767ffbd79a984da8957c::meni {
    struct MENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENI>(arg0, 9, b"MENI", b"Meme", b"Ox02ge02", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d7bd8e5-e234-4f10-a817-b5ef5e7b0606.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENI>>(v1);
    }

    // decompiled from Move bytecode v6
}

