module 0x2ae323cbe2469db98360bfc4532f6e547f1fea1c0835e7f720d637ccfa728630::frui {
    struct FRUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUI>(arg0, 6, b"FRUI", b"Frui On Sui", b"No roadmap, no promises, $FRUI is just a blue frog meme on SuiNetwork .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieirce2gs4trw5ootbb3lqk3ducugygw7dcsfpcstlabplvpy7drq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

