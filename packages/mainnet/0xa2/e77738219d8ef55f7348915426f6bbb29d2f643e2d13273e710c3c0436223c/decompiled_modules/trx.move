module 0xa2e77738219d8ef55f7348915426f6bbb29d2f643e2d13273e710c3c0436223c::trx {
    struct TRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX>(arg0, 6, b"TRX", b"TRX", b"TRX is a fixed-supply token on Sui. Mint authority renounced to 0x0 address.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqlaksegoji3yjff22ntacxnktafmweks4lcw52wwfac5wunq5by")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRX>>(0x2::coin::mint<TRX>(&mut v2, 3000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRX>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

