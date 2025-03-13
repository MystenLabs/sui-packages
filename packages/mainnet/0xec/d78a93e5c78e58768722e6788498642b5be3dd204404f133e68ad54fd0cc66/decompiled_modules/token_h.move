module 0xecd78a93e5c78e58768722e6788498642b5be3dd204404f133e68ad54fd0cc66::token_h {
    struct TOKEN_H has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_H>(arg0, 9, b"TKNH", b"TOKEN_H", b"Test token H", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/3688/standard/hbar.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_H>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_H>>(v1);
    }

    // decompiled from Move bytecode v6
}

