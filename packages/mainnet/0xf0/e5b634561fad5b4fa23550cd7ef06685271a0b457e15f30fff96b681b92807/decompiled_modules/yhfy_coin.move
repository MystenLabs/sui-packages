module 0xf0e5b634561fad5b4fa23550cd7ef06685271a0b457e15f30fff96b681b92807::yhfy_coin {
    struct YHFY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YHFY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YHFY_COIN>(arg0, 6, b"YHFY_COIN", b"YHFY_COIN", b"this is yhfy's coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img1.baidu.com/it/u=3921589634,1084294548&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YHFY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YHFY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

