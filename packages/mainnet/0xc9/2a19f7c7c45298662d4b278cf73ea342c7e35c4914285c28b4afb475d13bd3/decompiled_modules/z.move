module 0xc92a19f7c7c45298662d4b278cf73ea342c7e35c4914285c28b4afb475d13bd3::z {
    struct Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z>(arg0, 6, b"Z", b"Agent Z", b"Friend of Agent S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736057819328.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Z>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

