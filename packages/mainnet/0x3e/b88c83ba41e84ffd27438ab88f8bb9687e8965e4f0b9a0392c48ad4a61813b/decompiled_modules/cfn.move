module 0x3eb88c83ba41e84ffd27438ab88f8bb9687e8965e4f0b9a0392c48ad4a61813b::cfn {
    struct CFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFN>(arg0, 6, b"CFN", b"CATI FUN", b"Cat who Makeup like a joker.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760588801682.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

