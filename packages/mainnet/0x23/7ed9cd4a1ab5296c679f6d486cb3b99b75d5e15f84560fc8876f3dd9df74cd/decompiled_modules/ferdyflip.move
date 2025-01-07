module 0x237ed9cd4a1ab5296c679f6d486cb3b99b75d5e15f84560fc8876f3dd9df74cd::ferdyflip {
    struct FERDYFLIP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FERDYFLIP>, arg1: 0x2::coin::Coin<FERDYFLIP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FERDYFLIP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FERDYFLIP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: FERDYFLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERDYFLIP>(arg0, 6, b"FerdyFlip", b"FERDY", b"Decentralized casino with revenue-sharing NFTs  https://www.ferdyflip.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dashboard-assets.dappradar.com/document/47500/ferdyflip-project-gambling-47500-logo-166x166_fc99a239d323fdbf59b6fa9842913d1f.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FERDYFLIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERDYFLIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<FERDYFLIP>, arg1: 0x2::coin::Coin<FERDYFLIP>) : u64 {
        0x2::coin::burn<FERDYFLIP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FERDYFLIP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FERDYFLIP> {
        0x2::coin::mint<FERDYFLIP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

