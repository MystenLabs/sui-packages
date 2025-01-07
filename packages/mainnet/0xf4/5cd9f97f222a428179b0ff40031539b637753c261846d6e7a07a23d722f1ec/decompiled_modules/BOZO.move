module 0xf45cd9f97f222a428179b0ff40031539b637753c261846d6e7a07a23d722f1ec::BOZO {
    struct BOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZO>(arg0, 9, b"BOZO", b"SUI BOZO", b"BOZO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img-cdn.magiceden.dev/rs:fill:400:0:0/plain/https://nftstorage.link/ipfs/bafkreiamobqahwlwio5syavvfkknvfecgt7osbsh2s4xizihgpsajethyy")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOZO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOZO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOZO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOZO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

