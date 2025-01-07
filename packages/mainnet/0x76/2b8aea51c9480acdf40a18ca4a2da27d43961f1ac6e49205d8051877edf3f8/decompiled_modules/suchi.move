module 0x762b8aea51c9480acdf40a18ca4a2da27d43961f1ac6e49205d8051877edf3f8::suchi {
    struct SUCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCHI>(arg0, 6, b"Suchi", b"Suchi the japanese sable", b"Cute lil japanese sable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13_V6a_T_P_400x400_6a01da6788.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

