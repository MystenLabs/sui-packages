module 0x6bdc1d76f23157919dc469b1a05621fc9d4c4efe9f1988c91b0bff2f2d08bdaf::groguonsuichain {
    struct GROGUONSUICHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGUONSUICHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGUONSUICHAIN>(arg0, 6, b"Groguonsuichain", b"Groguonsui", b"Nobody loves me but sui does", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000166197_b8e78975bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGUONSUICHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGUONSUICHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

