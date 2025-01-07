module 0x748ac9b9d193789a6d78809367e6f93f30c029b910cfe1f9fe52c85c7e4eb4a3::bagy {
    struct BAGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGY>(arg0, 6, b"BAGY", b"Bagy On Sui", b"Meet Bagy, the small frog with a big dream and a bag full of potential", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_L_Md8n4_A_400x400_776f7296f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

