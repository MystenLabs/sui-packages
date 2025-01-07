module 0x9a60bdef5a7a5d10c2f30087beb58a76d3981ef9f6df1e554c41dc731fe06a8d::tranhalinh {
    struct TRANHALINH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRANHALINH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRANHALINH>(arg0, 9, b"TRANHALINH", b"HALINH", b"TRAN HA LINH TOP 1 server", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42e62d65-eec2-484f-b022-2bbdb23219e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRANHALINH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRANHALINH>>(v1);
    }

    // decompiled from Move bytecode v6
}

