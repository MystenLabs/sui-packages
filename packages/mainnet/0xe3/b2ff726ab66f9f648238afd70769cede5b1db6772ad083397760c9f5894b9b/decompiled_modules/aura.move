module 0xe3b2ff726ab66f9f648238afd70769cede5b1db6772ad083397760c9f5894b9b::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 9, b"AURA", b"BUREAUCRACY", b"BUREAUCRACY ELON X TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUduJdCzaHG5gVJe4TWDhG2xhbqwhBiXDh17Nr75CSyJ9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AURA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

