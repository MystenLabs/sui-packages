module 0x6d7013dd4d80790920073570a2b26fe4677f4a217d2964091fa4c3386e7e58ba::swi {
    struct SWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWI>(arg0, 9, b"SWI", b"Suwiii", b"just meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c20574b-1ced-4842-a540-271cbf29b015.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

