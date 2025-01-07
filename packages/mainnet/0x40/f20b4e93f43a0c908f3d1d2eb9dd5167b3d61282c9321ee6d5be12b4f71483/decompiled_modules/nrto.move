module 0x40f20b4e93f43a0c908f3d1d2eb9dd5167b3d61282c9321ee6d5be12b4f71483::nrto {
    struct NRTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRTO>(arg0, 9, b"NRTO", b"Naruto", b"Meme Heros", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75a8cd6f-92be-4457-8b73-e32488bafb1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

