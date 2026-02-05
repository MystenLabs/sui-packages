module 0x29eb53278fd557115e399bc1e07899adc9f53320470c3809b76f70b9cff5ea4b::tencent {
    struct TENCENT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TENCENT>, arg1: 0x2::coin::Coin<TENCENT>) {
        0x2::coin::burn<TENCENT>(arg0, arg1);
    }

    fun init(arg0: TENCENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENCENT>(arg0, 6, b"Tencent", b"Tencent", b"Tencent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1916391858873458688/3Zf6usy__normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TENCENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENCENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TENCENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TENCENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

