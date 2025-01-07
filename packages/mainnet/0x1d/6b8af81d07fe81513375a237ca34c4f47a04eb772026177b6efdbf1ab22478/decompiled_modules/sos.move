module 0x1d6b8af81d07fe81513375a237ca34c4f47a04eb772026177b6efdbf1ab22478::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"Squide On Sui", b"Squide The Pearl OF SUI, The cryptocurrency market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SQUIDE_0bdb078da4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

