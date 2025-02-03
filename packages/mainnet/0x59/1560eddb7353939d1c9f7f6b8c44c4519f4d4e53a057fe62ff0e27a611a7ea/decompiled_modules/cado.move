module 0x591560eddb7353939d1c9f7f6b8c44c4519f4d4e53a057fe62ff0e27a611a7ea::cado {
    struct CADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CADO>(arg0, 6, b"CADO", b"Cado On Sui", b"the cat is a dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032604_7be3b04125.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

