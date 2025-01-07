module 0xbfbabe0b177ffd4ec218e383f5861f030d6c4bb1c9e72c039d079605a1910578::gangsta {
    struct GANGSTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGSTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGSTA>(arg0, 9, b"GANGSTA", b"Sui Gangster Seal", b"Gangster Seal of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JV5Dws2.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GANGSTA>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGSTA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANGSTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

