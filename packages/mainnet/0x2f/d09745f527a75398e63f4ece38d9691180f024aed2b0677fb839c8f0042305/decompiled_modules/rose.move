module 0x2fd09745f527a75398e63f4ece38d9691180f024aed2b0677fb839c8f0042305::rose {
    struct ROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE>(arg0, 6, b"ROSE", b"Sui Rose", b"Blue bitch ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rose_da4e46c8d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

