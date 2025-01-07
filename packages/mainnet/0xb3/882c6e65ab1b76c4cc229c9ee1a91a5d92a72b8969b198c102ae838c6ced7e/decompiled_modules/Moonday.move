module 0xb3882c6e65ab1b76c4cc229c9ee1a91a5d92a72b8969b198c102ae838c6ced7e::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/goku.gif" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/goku.gif"))
        };
        0x94650ced50b6ada2a3c042c219211b8384a7bae4c599ab4ae53e01e0759b7fbf::factory::new<MOONDAY>(arg0, 1000000000, b"GOKU", b"Goku Coin", b"Goku is the main protagonist and hero of the Dragon Ball manga series and animated television series created by Akira Toriyama. He is one of the survivors of the extinct Saiyan race. He was sent as a baby to planet Earth in order to destroy it. When he arrived he was a violent kid, due to his warrior nature.", v0, false, 0x1::fixed_point32::create_from_rational(100000000, 78094651), arg1);
    }

    // decompiled from Move bytecode v6
}

