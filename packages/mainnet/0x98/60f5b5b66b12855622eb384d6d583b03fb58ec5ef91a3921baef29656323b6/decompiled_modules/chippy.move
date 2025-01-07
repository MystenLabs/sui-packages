module 0x9860f5b5b66b12855622eb384d6d583b03fb58ec5ef91a3921baef29656323b6::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: 0x2::coin::Coin<CHIPPY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIPPY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"Chippy Sui", b"DRAMATIC CHIPPY $CHIPPY IS A VIRAL INTERNET 5-SECOND CLIP OF A PRAIRIE DOG. https://www.chipppy.xyz/  https://x.com/ChippySuii  https://t.me/chippysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUwy7HM6pXEferqxxmcSmM1QaPYJ3Z4wFP4LyZVRSHYzu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: 0x2::coin::Coin<CHIPPY>) : u64 {
        0x2::coin::burn<CHIPPY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<CHIPPY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CHIPPY> {
        0x2::coin::mint<CHIPPY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

