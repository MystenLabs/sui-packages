module 0xc72ccde576717e9734979cf658fb77608baceaa32623ef02cc7690b8edcb4f4a::pluflo {
    struct PLUFLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFLO>(arg0, 6, b"Pluflo", b"PlufloToken", b"Pluflo for fun memes and a vibrant community. Dont miss it,  join the excitement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_223028_ad07ea5cb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

