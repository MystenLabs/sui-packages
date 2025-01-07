module 0x2124e200c6020fa82b35f633060ece84658c5bb0b1342af7ae8c8eeb34cb2a4c::sopcat {
    struct SOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPCAT>(arg0, 6, b"SOPCAT", b"SOPCATSUI", b"Inspired from the popular meme-cat named \"Popcat\", Sopcat just dropped on SUI Network! No longer just a meme,Its here! The legendary Sopcat has arrived on SUI, and this isnt just any coin dropits the ultimate meme slap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958176130.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

