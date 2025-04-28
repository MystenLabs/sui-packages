module 0x12d5a81497ac5ff1d44df1aae8e8c96f43f2bc8de7e9b714811379cbeff8cb19::suikachu {
    struct SUIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKACHU>(arg0, 6, b"SUIKACHU", b"Pikachu On Sui", b"PIKACHU EXPLORING SUI BLOCKCHAIN FRRR...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_28_13_44_00_7d8e037e96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

