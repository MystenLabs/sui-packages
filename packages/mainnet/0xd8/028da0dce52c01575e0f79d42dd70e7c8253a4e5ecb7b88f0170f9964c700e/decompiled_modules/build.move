module 0xd8028da0dce52c01575e0f79d42dd70e7c8253a4e5ecb7b88f0170f9964c700e::build {
    struct BUILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUILD>(arg0, 6, b"BUILD", b"USE BUILD", b"Build Custom AI Agents That Work For You - Powered by SUI and SOLANA Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736055155317.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUILD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUILD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

