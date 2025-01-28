module 0xb89fa11c03fa6cdbb05a1438f99fe7ec6aed6f8457f7621751befb3cc6ed9f8d::deepfuck {
    struct DEEPFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPFUCK>(arg0, 9, b"DEEPFUCK", b"Deepfuck", b"Deepseek fucked chatgpt with a fraction of the money spent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPSEWj7kDSDWacVhpUSAfhit6dA6cije95ETbvnzJus9d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEPFUCK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEPFUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPFUCK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

