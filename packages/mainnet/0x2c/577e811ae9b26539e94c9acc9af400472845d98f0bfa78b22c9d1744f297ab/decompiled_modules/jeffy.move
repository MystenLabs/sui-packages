module 0x2c577e811ae9b26539e94c9acc9af400472845d98f0bfa78b22c9d1744f297ab::jeffy {
    struct JEFFY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JEFFY>, arg1: 0x2::coin::Coin<JEFFY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JEFFY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JEFFY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: JEFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEFFY>(arg0, 6, b"$JEFFY", b"Jeffy Z0os", b"Hey You are you ready to build  https://www.jeffy.online/  https://x.com/Jeffyzos  https://t.me/jeffyzoos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmadcneaQLRv3wDX8rLxXvo53N92uN6c4zeuSUv87qkfcw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<JEFFY>, arg1: 0x2::coin::Coin<JEFFY>) : u64 {
        0x2::coin::burn<JEFFY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<JEFFY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JEFFY> {
        0x2::coin::mint<JEFFY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

