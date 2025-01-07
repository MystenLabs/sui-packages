module 0xdffa2af8b064ea2e6913319646eab0d590a755ce20db8df253d5ccd258f96e82::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEN>(arg0, 6, b"Gen", b"Sui Generation", b"New generation token on Sui. Sui Generation ($Gen) aims to be the first new generation token that is useful in building game projects, exchanging game items into the game's own coins (mining points, game nfts: characters, equipment, as well as in-game weapons). And in the future, a dex project will be opened for this coin itself with the aim of making coin circulation more stable with the existence of this market itself. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000165598_bcb8badcb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

