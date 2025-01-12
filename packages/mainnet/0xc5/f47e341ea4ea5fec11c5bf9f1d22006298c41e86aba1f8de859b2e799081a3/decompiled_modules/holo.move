module 0xc5f47e341ea4ea5fec11c5bf9f1d22006298c41e86aba1f8de859b2e799081a3::holo {
    struct HOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLO>(arg0, 9, b"HOLO", b"Holozone", b"The most advanced AI Agent framework on the blockchain is here. Create your own agents or 'clone' the personalities and traits of real life humans. Equip your AI agents with advanced multimodal capabilities and features. Join the 24/7 HoloSpace on X for a live demonstration of Holos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNdoSm354T3GWRiYxkK6NB7uZBvwnaUz24t6vTZELExxB")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOLO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

