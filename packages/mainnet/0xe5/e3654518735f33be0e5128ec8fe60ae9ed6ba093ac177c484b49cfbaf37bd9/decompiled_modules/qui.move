module 0xe5e3654518735f33be0e5128ec8fe60ae9ed6ba093ac177c484b49cfbaf37bd9::qui {
    struct QUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUI>(arg0, 9, b"QUI", b"QUIRKY", b"Quirky is all about celebrating the weird and wonderful. Imagine a coin that's a little bit offbeat, a little bit sarcastic, and a whole lot of fun. Quirky's community would be all about embracing what makes you unique and having a good laugh.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeic7i4nnacgdk2y4un5qyu4damfucv4tew4xas72dle6g37aaybexq")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

