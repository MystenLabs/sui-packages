module 0xeb529d0527a7b39560258b29c30699f256ee841d158b91558bfc39ad8c429218::cty {
    struct CTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTY>(arg0, 9, b"CTY", b"CITY SKY", b"NIGHT CITY SKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/912d2db9-6ede-4882-a5e8-22e65e77b088.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

