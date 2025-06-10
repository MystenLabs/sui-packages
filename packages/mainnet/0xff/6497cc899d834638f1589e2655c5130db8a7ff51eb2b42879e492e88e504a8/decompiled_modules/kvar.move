module 0xff6497cc899d834638f1589e2655c5130db8a7ff51eb2b42879e492e88e504a8::kvar {
    struct KVAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KVAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KVAR>(arg0, 6, b"KVAR", b"Kvaker", b"game token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihem3rmb6ex5au65ka7ilug4lotqyeks5ljitjklsiun5pdn3iive")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KVAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KVAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

