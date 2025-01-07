module 0xb3f53bbf618b99a7a7556b645007a127992aa29a738164132c4cb5d9c639fe4c::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 9, b"ONE", b"Chosen One", b"It evokes the Chosen One with cybernetic nature of the AI while implying power and control through its \"chained\" structure. All the multi-agents blended into a single entity, the Chosen One.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme9mydhccGHwyLSMcB31HqqAN29nPAFZpyUX6cXSHFdT5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

