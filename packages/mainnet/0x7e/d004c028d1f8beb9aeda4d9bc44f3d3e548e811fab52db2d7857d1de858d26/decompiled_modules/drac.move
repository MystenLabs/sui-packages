module 0x7ed004c028d1f8beb9aeda4d9bc44f3d3e548e811fab52db2d7857d1de858d26::drac {
    struct DRAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAC>(arg0, 6, b"DRAC", b"DRACULA", b"Dracula is a community for discerning gentlemen who wish to help each other fulfill ALL their desires. We use the crypto currency $DRAC to designate rank.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DRACULA_ba4befadec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

