module 0x23bea2bf45ecf9851dcb4705eda07ae6e72f7ec9e62ee5449fbe22a8252a0d99::infi {
    struct INFI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<INFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<INFI>>(0x2::coin::mint<INFI>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: INFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFI>(arg0, 9, b"INFI", b"Infini Drop", b"NFT GATED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://127.0.0.1:54321/storage/v1/object/public/drop-images/b11b7bce-8f7e-4bb8-bbee-17eb0386f67e.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<INFI>>(0x2::coin::mint<INFI>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

