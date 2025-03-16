module 0x1c91023d316026c9c1bcd0f9d9753866d1de80291164b885a35d3650b8b1a616::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<JOKER>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JOKER>>(arg0);
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 9, b"JOKER", b"Code of Joker Token", b"Based on the hit arcade game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-tiny-shrimp-206.mypinata.cloud/ipfs/bafybeibthtek7sprmrv7nffpkatnsbubtldazkqevyxntcadyywjeboxpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOKER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOKER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOKER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

