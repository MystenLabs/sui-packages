module 0x12773feb04053c04824bc592685f07b09ede7ff88234304f815dd0637068c05a::catyson {
    struct CATYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATYSON>(arg0, 6, b"CATYSON", b"Catyson", x"47657474696e6720696e746f207468652063617420687970652c204920696e74726f6475636520796f7520746f2043415459534f4e2e0a42652070617274206f6620686973746f727920616e6420746865206669676874206f66206f757220626f78657220616761696e737420746865206a6565747320746f2072656163682074686520746f70206f662074686520776f726c6420616e64206265636f6d65206368616d70696f6e206f66206d656d65636f696e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_07_19_T181900_678_531ba6d2a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

