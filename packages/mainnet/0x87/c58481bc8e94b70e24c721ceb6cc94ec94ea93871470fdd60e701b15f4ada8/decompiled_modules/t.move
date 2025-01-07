module 0x87c58481bc8e94b70e24c721ceb6cc94ec94ea93871470fdd60e701b15f4ada8::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 6, b"t", b"t", b" t", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T>(&mut v2, 10000000000000, @0xfc157f93a91c84490d971ac621620398d1f870681a0fef9df9254327ee0a794a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

