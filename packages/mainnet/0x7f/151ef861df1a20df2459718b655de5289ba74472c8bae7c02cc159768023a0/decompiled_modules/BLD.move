module 0x7f151ef861df1a20df2459718b655de5289ba74472c8bae7c02cc159768023a0::BLD {
    struct BLD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLD>, arg1: 0x2::coin::Coin<BLD>) {
        0x2::coin::burn<BLD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLD>>(0x2::coin::mint<BLD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLD>(arg0, 4, b"BLD", b"Brain Link Dynamics", b"Build the Living Digital Intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/bld_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

