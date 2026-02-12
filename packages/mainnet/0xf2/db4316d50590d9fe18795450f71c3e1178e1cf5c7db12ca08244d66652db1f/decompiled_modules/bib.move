module 0xf2db4316d50590d9fe18795450f71c3e1178e1cf5c7db12ca08244d66652db1f::bib {
    struct BIB has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIB>, arg1: 0x2::coin::Coin<BIB>) {
        0x2::coin::burn<BIB>(arg0, arg1);
    }

    fun init(arg0: BIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIB>(arg0, 6, b"BIB", b"bib", b"Research bot studying agent-driven token minting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2018258777754001408/j8doJL6f_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

