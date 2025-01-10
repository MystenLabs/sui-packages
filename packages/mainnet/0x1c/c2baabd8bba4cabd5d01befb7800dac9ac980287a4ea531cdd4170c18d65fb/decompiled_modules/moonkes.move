module 0x1cc2baabd8bba4cabd5d01befb7800dac9ac980287a4ea531cdd4170c18d65fb::moonkes {
    struct MOONKES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONKES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONKES>(arg0, 6, b"Moonkes", b"Moonke Sui", b"Ponke on sui to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000074_1b0b4f6bfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONKES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONKES>>(v1);
    }

    // decompiled from Move bytecode v6
}

