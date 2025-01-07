module 0x62b46e262f125aa7417460ae85bdea1c7142f2e64635a75413353cda8ac2705e::suimumu {
    struct SUIMUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUMU>(arg0, 6, b"SUIMUMU", b"MUMU THE BULL on SUI", b"Bullieve in something ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cy4_Al_P30_400x400_b021ae3930.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

