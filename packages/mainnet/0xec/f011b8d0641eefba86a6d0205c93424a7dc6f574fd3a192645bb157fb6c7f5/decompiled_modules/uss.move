module 0xecf011b8d0641eefba86a6d0205c93424a7dc6f574fd3a192645bb157fb6c7f5::uss {
    struct USS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USS>(arg0, 9, b"USS", b"usa", b"usa ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43604913-5436-46ca-bd56-34e825025bf3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USS>>(v1);
    }

    // decompiled from Move bytecode v6
}

