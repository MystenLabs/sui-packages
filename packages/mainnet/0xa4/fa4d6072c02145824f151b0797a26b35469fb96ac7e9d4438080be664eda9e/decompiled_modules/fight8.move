module 0xa4fa4d6072c02145824f151b0797a26b35469fb96ac7e9d4438080be664eda9e::fight8 {
    struct FIGHT8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT8>(arg0, 6, b"Fight8", b"Fight", b"To fight for America to rise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730895329406.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGHT8>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT8>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

