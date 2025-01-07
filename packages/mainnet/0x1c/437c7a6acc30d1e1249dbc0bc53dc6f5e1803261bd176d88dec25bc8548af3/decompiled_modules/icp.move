module 0x1c437c7a6acc30d1e1249dbc0bc53dc6f5e1803261bd176d88dec25bc8548af3::icp {
    struct ICP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICP>(arg0, 8, b"ICP", b"ICP", b"Internet Computer Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/octopus-network/omnity-interoperability/9061b7e2ea9e0717b47010279ff1ffd6f1f4c1fc/assets/token_logo/icp.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

