module 0xad205532964b45afe0da09c9a785b24bdd2973b1f2cc0b1690e4b64beaad6e7a::bullrun {
    struct BULLRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLRUN>(arg0, 6, b"BULLRUN", b"Sui Bull Run", b"Meet $BULLRUN. Suis unstoppable memecoin for an unstoppable chain. With Sui hitting ATHs daily, $BULLRUN is charging ahead, embodying the wild energy of the Sui ecosystem. Buckle up. its bull season! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_5_db12c9eb04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLRUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

