module 0x72b98862793123d633fcc2673f417d30c3e156970c60b11fbf5aa003d92f23ea::gfd {
    struct GFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFD>(arg0, 9, b"GFD", b"GGK", b"Flyby is a mistake ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/950076aa-53bc-4719-869c-494821c39299.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

