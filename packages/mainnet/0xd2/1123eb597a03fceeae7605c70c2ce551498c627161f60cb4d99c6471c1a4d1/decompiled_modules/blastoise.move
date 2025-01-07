module 0xd21123eb597a03fceeae7605c70c2ce551498c627161f60cb4d99c6471c1a4d1::blastoise {
    struct BLASTOISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTOISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTOISE>(arg0, 2, b"BLAST", b"Blastoise", b"Another Beast of SUI, blasting water all over chain. Blastoise will be fully community operated.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r2.easyimg.io/1hxk8piew/blastoiseasset_1@300x.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLASTOISE>>(v1);
        0x2::coin::mint_and_transfer<BLASTOISE>(&mut v2, 50000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTOISE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

