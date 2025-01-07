module 0x64c2fd9677e0ccc0e621da433510a8b476ae6a2b9c91f49fe044177ade9c6faa::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAB>(arg0, 6, b"CRAB", b"CRABSUI", b"Crab Mission: Operation Ocean Guardians**  CrabSui's mission is to protect a designated underwater habitat inhabited by endangered crab species from pollution and invasive predators. Assemble a team of marine conservationists and divers to conduct a thorough assessment of the area, document biodiversity, and engage in community outreach to raise awareness about ocean conservation. Develop a plan to implement underwater clean-up activities and create protective zones where the crabs can thrive safely. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_f0f8e161fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

