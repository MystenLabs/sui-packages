module 0x57362980ebf5f9414a6a808ba20a50bfbea834ec0be9c3a17a2c3db6391831a5::izzy {
    struct IZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZY>(arg0, 6, b"IZZY", b"IZZY COIN ON SUI", b"$IZZY , Matt Furie's Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hs_Q_Qi_Y_Fx_400x400_2d3645792c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

