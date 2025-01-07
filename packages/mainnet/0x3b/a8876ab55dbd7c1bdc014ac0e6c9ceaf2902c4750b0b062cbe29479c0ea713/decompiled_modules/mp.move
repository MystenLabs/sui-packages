module 0x3ba8876ab55dbd7c1bdc014ac0e6c9ceaf2902c4750b0b062cbe29479c0ea713::mp {
    struct MP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MP>(arg0, 6, b"MP", b"MemeParty", x"57656c636f6d6520746f207468652062657374206d656d652070617274792073696e636520746865206c617374206d656d65636f696e20736561736f6e2c206f6e6c79206f6e20746865200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smp_0554d57794.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MP>>(v1);
    }

    // decompiled from Move bytecode v6
}

