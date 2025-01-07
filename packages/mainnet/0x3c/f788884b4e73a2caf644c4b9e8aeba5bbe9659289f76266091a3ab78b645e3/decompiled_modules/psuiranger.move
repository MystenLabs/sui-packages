module 0x3cf788884b4e73a2caf644c4b9e8aeba5bbe9659289f76266091a3ab78b645e3::psuiranger {
    struct PSUIRANGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUIRANGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUIRANGER>(arg0, 6, b"PSUIRANGER", b"Power Sui Ranger", x"49742773204d6f727068696e2054696d65210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_39_935580623a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUIRANGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUIRANGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

