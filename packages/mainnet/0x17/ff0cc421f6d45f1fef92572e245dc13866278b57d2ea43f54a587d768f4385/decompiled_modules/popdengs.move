module 0x17ff0cc421f6d45f1fef92572e245dc13866278b57d2ea43f54a587d768f4385::popdengs {
    struct POPDENGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENGS>(arg0, 6, b"POPDENGS", b"POPDENG", b"POPDEENG IS LIVEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POOOPDE_Ng_a4d147d2f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

