module 0x474f625abb0be6f3cc84e263524ceb5da2765a3ba7acdfdd4832091381e0b19d::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"BLUB ($BLUB)", b"A Dirty Fish in the Waters of the Sui Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735929988736.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

