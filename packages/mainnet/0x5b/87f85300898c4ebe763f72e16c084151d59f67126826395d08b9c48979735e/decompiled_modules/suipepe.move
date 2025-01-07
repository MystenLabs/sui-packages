module 0x5b87f85300898c4ebe763f72e16c084151d59f67126826395d08b9c48979735e::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 9, b"SUIPEPE", b"SUIPEPE", b"SUIPEPE is here to make memecoins great on SUI. Launched stealth with no presale, zero taxes, LP burnt and contract renounced, $SUIPEPE is a coin for the people, forever. Fueled by pure memetic power, let $SUIPEPE show you the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://5571439ff3b84351542df602fcfb9256.ipfscdn.io/ipfs/QmX34A8K9bn6t5ep4p6pccTnvo7Rd9AdcBvtPY5FBVRuF1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

