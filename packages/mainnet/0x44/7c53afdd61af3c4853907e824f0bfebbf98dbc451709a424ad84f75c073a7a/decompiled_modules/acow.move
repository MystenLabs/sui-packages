module 0x447c53afdd61af3c4853907e824f0bfebbf98dbc451709a424ad84f75c073a7a::acow {
    struct ACOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACOW>(arg0, 6, b"ACOW", b"Autistic COW", b"autistic COW EAT EAGLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_86eil_X0_A_Ae5_No_ee85b43d27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

