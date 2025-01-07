module 0x8f2de832f0840a79184303f8f4e9ae3eeabc95e7301b7226f6093d2ac158a626::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"blub blub blub ", b"A Dirty Fish in the Waters of the Sui Ocean. The #1 Meme on $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952079298.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

