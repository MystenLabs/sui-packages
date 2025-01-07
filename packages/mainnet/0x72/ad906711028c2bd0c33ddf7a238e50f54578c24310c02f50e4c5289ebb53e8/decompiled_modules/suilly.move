module 0x72ad906711028c2bd0c33ddf7a238e50f54578c24310c02f50e4c5289ebb53e8::suilly {
    struct SUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLY>(arg0, 6, b"SUILLY", b"Suilly On Sui", b"$SUILLY IS THE CUTEST ANIMAL ON SUI, ON A MISSION TO BE WORTH SUILLYONS AND SUILLYONS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_082148_19a0589c27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

