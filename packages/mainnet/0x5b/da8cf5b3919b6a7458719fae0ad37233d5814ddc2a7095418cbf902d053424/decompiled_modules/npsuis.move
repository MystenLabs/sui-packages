module 0x5bda8cf5b3919b6a7458719fae0ad37233d5814ddc2a7095418cbf902d053424::npsuis {
    struct NPSUIS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NPSUIS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NPSUIS>>(0x2::coin::mint<NPSUIS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NPSUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPSUIS>(arg0, 6, b"Non Playable Sui's", b"NPSUIS", b"NPC's are fed up of being rugged on Sol so they've bridged to NPSUI's.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPSUIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPSUIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

