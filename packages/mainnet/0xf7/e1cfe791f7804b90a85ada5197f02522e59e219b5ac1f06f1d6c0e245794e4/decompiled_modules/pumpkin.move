module 0xf7e1cfe791f7804b90a85ada5197f02522e59e219b5ac1f06f1d6c0e245794e4::pumpkin {
    struct PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIN>(arg0, 9, b"PUMPkin", b"Poor Pumpkin", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/769/432/large/manu-dorado-pumpkinhigh-render01.jpg?1728468851")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMPKIN>(&mut v2, 500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

