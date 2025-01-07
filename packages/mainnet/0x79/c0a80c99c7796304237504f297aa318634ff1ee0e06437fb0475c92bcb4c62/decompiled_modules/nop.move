module 0x79c0a80c99c7796304237504f297aa318634ff1ee0e06437fb0475c92bcb4c62::nop {
    struct NOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOP>(arg0, 6, b"NOP", b"NOP.FUN", b"Nop we are not launching.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Katman_2_e52a4e0356.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

