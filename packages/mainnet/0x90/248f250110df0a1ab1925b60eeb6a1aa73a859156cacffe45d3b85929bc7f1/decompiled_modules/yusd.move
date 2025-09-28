module 0x90248f250110df0a1ab1925b60eeb6a1aa73a859156cacffe45d3b85929bc7f1::yusd {
    struct YUSD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YUSD>, arg1: 0x2::coin::Coin<YUSD>) {
        0x2::coin::burn<YUSD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YUSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YUSD>>(0x2::coin::mint<YUSD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSD>(arg0, 4, b"YUSD", b"YUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://galactic100.s3.us-west-1.amazonaws.com/yusd.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

