module 0x62459a5794b12168fa47e062f3f09b4abac2b94a014ef222018e2a23b38fa42::nepe {
    struct NEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPE>(arg0, 6, b"NEPE", b"Nepe Sui", b"I am NEPE.A clownfish that likes to take selfies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1x1_2_768x768_3c056324d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

