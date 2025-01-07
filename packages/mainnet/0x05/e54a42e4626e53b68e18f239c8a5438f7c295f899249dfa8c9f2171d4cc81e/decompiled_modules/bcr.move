module 0x5e54a42e4626e53b68e18f239c8a5438f7c295f899249dfa8c9f2171d4cc81e::bcr {
    struct BCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCR>(arg0, 6, b"BCR", b"BOB THE CRAB", b"BOB THE CRAB'S  mission is to protect a designated underwater habitat inhabited by endangered crab species from pollution and invasive predators. Assemble a team of marine conservationists and divers to conduct a thorough assessment of the area, document biodiversity, and engage in community outreach to raise awareness about ocean conservation. Develop a plan to implement underwater clean-up activities and create protective zones where the crabs can thrive safely. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_0f7ffc190f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

