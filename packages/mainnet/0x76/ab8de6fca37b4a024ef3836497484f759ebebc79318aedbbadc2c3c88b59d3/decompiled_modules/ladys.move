module 0x76ab8de6fca37b4a024ef3836497484f759ebebc79318aedbbadc2c3c88b59d3::ladys {
    struct LADYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYS>(arg0, 6, b"LADYS", b"LADY SUI", b"The Ladys On Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_9_bd33555da7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

