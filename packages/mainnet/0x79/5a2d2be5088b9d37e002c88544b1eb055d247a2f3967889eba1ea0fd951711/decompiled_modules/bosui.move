module 0x795a2d2be5088b9d37e002c88544b1eb055d247a2f3967889eba1ea0fd951711::bosui {
    struct BOSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOSUI>, arg1: 0x2::coin::Coin<BOSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSUI>(arg0, 6, b"BOSUI", b"BOSUI", b"Born from an autistic, $BOSUI is ready to embark on a series of conquests. https://bosuicoin.io/  https://x.com/bosuicoin  https://t.me/bosuiportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmXjrzuSaiJNP8bjaRbX6JxARQqnXCWR45vcxHGYzaHLi8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BOSUI>, arg1: 0x2::coin::Coin<BOSUI>) : u64 {
        0x2::coin::burn<BOSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BOSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOSUI> {
        0x2::coin::mint<BOSUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

