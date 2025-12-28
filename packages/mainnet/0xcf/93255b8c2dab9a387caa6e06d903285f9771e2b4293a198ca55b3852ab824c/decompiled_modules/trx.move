module 0xcf93255b8c2dab9a387caa6e06d903285f9771e2b4293a198ca55b3852ab824c::trx {
    struct TRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX>(arg0, 6, b"TRX", b"TRX", b"TRX is a fixed-supply token on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqlaksegoji3yjff22ntacxnktafmweks4lcw52wwfac5wunq5by")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRX>>(0x2::coin::mint<TRX>(&mut v2, 3000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRX>>(v2);
    }

    // decompiled from Move bytecode v6
}

