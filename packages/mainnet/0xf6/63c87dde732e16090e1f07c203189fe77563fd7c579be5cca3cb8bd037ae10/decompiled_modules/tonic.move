module 0xf663c87dde732e16090e1f07c203189fe77563fd7c579be5cca3cb8bd037ae10::tonic {
    struct TONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONIC>(arg0, 9, b"TONIC", b"Tonic On Sui", b"https://medium.com/@TonicTheBonkDog/tonic-unleashed-the-shiba-that-shaped-solanas-memecoin-movement-b49bd716357a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sapphire-working-koi-276.mypinata.cloud/ipfs/bafybeihjtg26cvdoezvgoxqhhzkjw256n4au25e44ubl2cq7ntqhvw745m")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TONIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

