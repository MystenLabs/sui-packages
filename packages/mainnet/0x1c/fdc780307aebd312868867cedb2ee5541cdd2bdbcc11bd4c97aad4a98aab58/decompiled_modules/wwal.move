module 0x1cfdc780307aebd312868867cedb2ee5541cdd2bdbcc11bd4c97aad4a98aab58::wwal {
    struct WWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWAL>(arg0, 6, b"wWAL", b"Walrus Warp", b"$wWAL is a very advanced memecoin currency, can be used for safe and efficient interface transactions,the native token is $WAL we will add a memecoin currency interface $wWAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076432_a88382896a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

