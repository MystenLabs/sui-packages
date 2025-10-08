module 0x29ae06dd3568d86f8ba741ca748dd99c3334b5b0805bb397e2f2c780965c9dcf::d18803731 {
    struct D18803731 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D18803731, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D18803731>(arg0, 18, b"D18803731", b"18 Decimal Token 1759892803731", b"Token with 18 decimals like ETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D18803731>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D18803731>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

