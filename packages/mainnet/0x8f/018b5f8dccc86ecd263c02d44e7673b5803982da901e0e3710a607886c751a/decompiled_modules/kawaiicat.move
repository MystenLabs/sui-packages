module 0x8f018b5f8dccc86ecd263c02d44e7673b5803982da901e0e3710a607886c751a::kawaiicat {
    struct KAWAIICAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAWAIICAT>, arg1: 0x2::coin::Coin<KAWAIICAT>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAWAIICAT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAWAIICAT>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KAWAIICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAWAIICAT>(arg0, 6, b"KCAT", b"Kawaii Cat", b"Kawaii Cat is a memecoin on the Sui that aims to become a popular cryptocurrency in the future.   https://www.kawaiicat.pro/   https://t.me/kawaicatsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/Qmbnx9NRuLmqhS3wCA3Dr8dwRtoa8w8QqgzC6FNq64FFdy")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAWAIICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAWAIICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KAWAIICAT>, arg1: 0x2::coin::Coin<KAWAIICAT>) : u64 {
        0x2::coin::burn<KAWAIICAT>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KAWAIICAT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KAWAIICAT> {
        0x2::coin::mint<KAWAIICAT>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

