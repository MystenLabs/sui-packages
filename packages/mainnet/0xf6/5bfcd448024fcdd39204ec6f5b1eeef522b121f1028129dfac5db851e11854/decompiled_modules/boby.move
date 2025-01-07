module 0xf65bfcd448024fcdd39204ec6f5b1eeef522b121f1028129dfac5db851e11854::boby {
    struct BOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBY>(arg0, 6, b"BOBY", b"sui boby", b"BOBY is an invisible little meme monster, and he will divert all purchases ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042381_bd496e584f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

