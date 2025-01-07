module 0xd35d1b9062da16ac01ee27e0b9d192d3c82b5f50b617bcfdea5e12a55fa8fc44::ew {
    struct EW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EW>(arg0, 6, b"EW", b"Even Water", b"Drink water to be healthy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_2_555a8b5461.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EW>>(v1);
    }

    // decompiled from Move bytecode v6
}

