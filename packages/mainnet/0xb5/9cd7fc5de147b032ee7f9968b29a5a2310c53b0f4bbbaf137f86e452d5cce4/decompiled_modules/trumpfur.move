module 0xb59cd7fc5de147b032ee7f9968b29a5a2310c53b0f4bbbaf137f86e452d5cce4::trumpfur {
    struct TRUMPFUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPFUR>(arg0, 6, b"TrumpFur", b"Trumpfurby", b"Trump Furby is a new Meme take on the classic Special Edition President's Furby that looks just like Trump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000094733_95bb76611e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPFUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

