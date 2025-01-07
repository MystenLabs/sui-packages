module 0x2a707a0a0de64fd799fd8a86d0d4225097049acae14344166c943b58325d9833::aaaaawif {
    struct AAAAAWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAWIF>(arg0, 6, b"AaaaaWIF", b"Aaawif", b"https://dogwifcoin.org/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016628_420a4d24e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

