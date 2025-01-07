module 0xc6824f41d25d3057b7841704dfe8e465e9b5858fec28fa4e0ae6f4c29f4ee83a::gd {
    struct GD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GD>(arg0, 9, b"GD", b"Good ", b"Good morning ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a0a4803-91fd-43c7-80f4-529e820aa67f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GD>>(v1);
    }

    // decompiled from Move bytecode v6
}

