module 0xa87204780e3dece688bfad421a61b8e6d7fab572a2b97fcd1f15502f9c38ce22::CAI {
    struct CAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CAI>, arg1: 0x2::coin::Coin<CAI>) {
        0x2::coin::burn<CAI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CAI>>(0x2::coin::mint<CAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAI>(arg0, 4, b"CAI", b"CAI", b"Collective Autonomous Intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/cai_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

