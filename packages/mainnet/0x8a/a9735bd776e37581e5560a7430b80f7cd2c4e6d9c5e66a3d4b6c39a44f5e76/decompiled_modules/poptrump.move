module 0x8aa9735bd776e37581e5560a7430b80f7cd2c4e6d9c5e66a3d4b6c39a44f5e76::poptrump {
    struct POPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTRUMP>(arg0, 6, b"POPTRUMP", b"POPTRUMP!", b"Make America Pop Again!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Lf_Ld_HVN_400x400_705e5a2125.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

