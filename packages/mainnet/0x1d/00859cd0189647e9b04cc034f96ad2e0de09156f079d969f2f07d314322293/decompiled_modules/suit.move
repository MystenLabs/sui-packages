module 0x1d00859cd0189647e9b04cc034f96ad2e0de09156f079d969f2f07d314322293::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 9, b"SUIT", b"SuiTools.io", b"SuiTools - Safety, Community and Fun - Visit our Website suitools.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"SuiTools - Safety, Community and Fun")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

