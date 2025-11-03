module 0x9c209446fe1f19eb06cecdff7c0ea35b6e401e7a5a57ff831d8b7f7692d604a9::nb {
    struct NB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NB>(arg0, 9, b"NB", b"Nubilee network", b"Nubilee network - Launched on SuiLFG MemeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifjeae6cs6zhkwflp3jswp33kz5xkpxzowfypuujmnawktfe6524q")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

