module 0x5890dbf4ca73d8b66123f5d1d08db0e75d187355fa4d676acf630e4c5fbc614e::bublsui {
    struct BUBLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBLSUI>(arg0, 6, b"BUBLSUI", b"BUBL", b"Bubbling on @SuiNetworkto make frens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J_Km_SPN_8_W_400x400_bd8af90d67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

