module 0xe66971e690236661008013f74824eff68638d019725e0f9aaa9a7733681362a2::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAD>(arg0, 6, b"DAD", b"BLUEY DAD", x"42616e6469742043757374617264204865656c657220697320426c75657920616e642042696e676f277320646164c2a0696ec2a0535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733461808940.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

