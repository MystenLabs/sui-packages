module 0xf9ffa1342249c57f0e6722c2c8d0bd55d98e1c7cbf77fd3738cb1b7272ce5af2::iearl {
    struct IEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEARL>(arg0, 6, b"iEarl", b"iEarl ON SUI", b"The thing that has legs come to sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/So_GK_Gjcc_400x400_e9d72587a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

