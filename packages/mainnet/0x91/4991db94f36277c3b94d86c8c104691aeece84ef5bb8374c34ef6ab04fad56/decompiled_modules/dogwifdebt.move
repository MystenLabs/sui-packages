module 0x914991db94f36277c3b94d86c8c104691aeece84ef5bb8374c34ef6ab04fad56::dogwifdebt {
    struct DOGWIFDEBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFDEBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFDEBT>(arg0, 6, b"DOGWIFDEBT", b"Dog Wif Debt", b"This Dog is in pain because he lost everything when sui tanked, memecoins are rugging. There's nothing to do other than make a 1 final move. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogwifdebt_79f9bc974e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFDEBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFDEBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

