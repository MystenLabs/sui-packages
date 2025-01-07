module 0xee9e383c7c2675d03cb261b2955eb261656b6ef0d9e28e17b391d8ce9c8f0dec::pwh {
    struct PWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWH>(arg0, 6, b"PWH", b"Pengu Wif Hat", b"First Pengi Wif Hat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3c55c4d0e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

