module 0x581d740fb3d2e05cd655775a6fe6a68cefd34393d5b9afd20c30d79b48267b58::salary {
    struct SALARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALARY>(arg0, 6, b"SALARY", b"SALARY on Sui", b"This will make your monthly Salary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicp57k6p55l5mkiqwv7lhntfreio3am2l74uaqpvzmfmdhar5hbbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SALARY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

