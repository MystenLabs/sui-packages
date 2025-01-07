module 0x898e9f7b9e105cbea32520dedfdac5fb4c8e7dc78d63b44d207d437b9835cd4b::tgh {
    struct TGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGH>(arg0, 9, b"TGH", b"GHOST TOWN", b"IF YOU DON,T BUY THIS MEME COIN YOU WILL BE HAunted in thr city of ghosts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/228dcb19-8e77-450d-9d39-cee7fc86eb88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

