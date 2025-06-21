module 0x8abe55c4c7a5c312e54bf9fdc3737a365d7bd9d842aff2664d09ce2883c8663f::labs {
    struct LABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABS>(arg0, 9, b"LABS", b"LaunchBOSU", b"With LaunchBOSU, you can turn your tweet into a coin on the Sui network. Just reply with @launchbosu name + ticker to activate. Powered by LABS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/LABS/refs/heads/main/LABS.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LABS>>(0x2::coin::mint<LABS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LABS>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

