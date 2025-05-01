module 0xd83bffeb63f0c20474331073e98cff88732d9aa6683e445b07badcb583f27107::ducke {
    struct DUCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKE>(arg0, 6, b"Ducke", b"DuckeSui", b"Ducke Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif7gwdbczeelm4to3ewnhoipqlxac52zlmpojeloqjtgvozuez4v4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUCKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

