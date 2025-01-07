module 0x16a4a13db13f96fd9f55561afe6e352bb810fbe37352a728ffae0ee39e7140dc::suirock {
    struct SUIROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROCK>(arg0, 6, b"SUIROCK", b"Sui Rock", b"$SUIROCK is the most useless meme coin to ever exist on Movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1b89fe24f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

