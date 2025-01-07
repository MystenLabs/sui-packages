module 0x14b27f22a7c8081bcb38a42eeafe8c1324f339df4b3132c158f9f332a782c02::boredcow {
    struct BOREDCOW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: 0x2::coin::Coin<BOREDCOW>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOREDCOW>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BOREDCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOREDCOW>(arg0, 6, b"$COW", b"BoredCow SUI", x"20544845204e455720e2809c424f52454420415045e2809d204f46204d454d4520434f494e5320202068747470733a2f2f7777772e626f726564636f772e78797a2f202068747470733a2f2f782e636f6d2f626f726564636f7753756920202068747470733a2f2f742e6d652f626f726564636f77737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/Qmf6jgJCLxUTrXSysQL9QgsmiyY1oicnfgyjyzfKsS162c")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOREDCOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOREDCOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: 0x2::coin::Coin<BOREDCOW>) : u64 {
        0x2::coin::burn<BOREDCOW>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOREDCOW> {
        0x2::coin::mint<BOREDCOW>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

