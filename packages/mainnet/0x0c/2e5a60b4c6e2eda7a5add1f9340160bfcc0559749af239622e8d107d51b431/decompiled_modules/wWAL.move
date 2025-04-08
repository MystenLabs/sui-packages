module 0xc2e5a60b4c6e2eda7a5add1f9340160bfcc0559749af239622e8d107d51b431::wWAL {
    struct WWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWAL>(arg0, 9, b"sywWAL", b"SY wWAL", b"SY wWAL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

