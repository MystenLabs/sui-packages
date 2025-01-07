module 0xede1ef4c39b1a72f4ff953d0c5c9229910de8593569e253916870884fcd67684::martin {
    struct MARTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARTIN>(arg0, 6, b"MARTIN", b"Martin on SUI", x"4d415254494e20686173206f6e65206f6620746865206265737420636f6d6d756e697479204920686176652065766572207365656e206f6e2063727970746f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M1xj_Dy_Dk_400x400_9d038213c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

