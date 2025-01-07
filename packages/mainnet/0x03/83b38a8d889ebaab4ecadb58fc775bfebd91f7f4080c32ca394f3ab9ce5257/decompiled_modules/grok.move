module 0x383b38a8d889ebaab4ecadb58fc775bfebd91f7f4080c32ca394f3ab9ce5257::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"GROK MEME", b"GROK Token: The only coin that knows everything... except when to stop pumping!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/95309117_d28b9ee34d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

