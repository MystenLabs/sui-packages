module 0x754789cac372fb56711b0577ff37453a1eb4c80cc5a62fedc103f4e1ef0325de::eiwu {
    struct EIWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIWU>(arg0, 9, b"EIWU", b"sdofjdokjf", b"fgjsklfgjkdfjgk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EIWU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIWU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

