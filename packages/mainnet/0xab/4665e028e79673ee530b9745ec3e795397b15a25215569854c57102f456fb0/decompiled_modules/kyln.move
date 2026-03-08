module 0xab4665e028e79673ee530b9745ec3e795397b15a25215569854c57102f456fb0::kyln {
    struct KYLN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KYLN>, arg1: 0x2::coin::Coin<KYLN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<KYLN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KYLN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KYLN>>(0x2::coin::mint<KYLN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KYLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYLN>(arg0, 9, b"KYLN", b"Kylin", b"Legacy Meets Liquidity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihsbwwu45hm5w2xf4ilqk6sqk46cvwsg75pu6hhoxlxgrmxk3huby?filename=kyln.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYLN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

