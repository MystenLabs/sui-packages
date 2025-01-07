module 0x24f8509a212839f265ab8d93517acb41bd3b893a0f7ce32835639669504fb2ad::zly {
    struct ZLY has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<ZLY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZLY>>(arg0, arg1);
    }

    fun init(arg0: ZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZLY>(arg0, 9, b"ZLY", b"Zealysui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZLY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

