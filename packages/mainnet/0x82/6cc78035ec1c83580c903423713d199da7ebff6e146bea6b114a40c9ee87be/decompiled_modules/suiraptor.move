module 0x826cc78035ec1c83580c903423713d199da7ebff6e146bea6b114a40c9ee87be::suiraptor {
    struct SUIRAPTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAPTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAPTOR>(arg0, 6, b"SUIRAPTOR", b"SUI RAPTOR", x"53554920524150544f5220697320696e73706972656420627920746865206669657263657374206f66204a7572617373696320576f726c642056656c6f6369726170746f720a424c554520696e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_RAPTOR_25_09_2024_1_5b35e7133e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAPTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAPTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

