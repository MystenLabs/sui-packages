module 0x3a4db5520cd9e8206f192483b62a132f3b71abe0d2367b9606945f089c5abf9b::wawoas {
    struct WAWOAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWOAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWOAS>(arg0, 9, b"WAWOAS", b"WAWOA", b"THAT TO THE DAY END ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/edd9afb3-beb5-4e94-87dc-0b191ea44ad6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWOAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWOAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

