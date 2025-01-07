module 0xe7b53e5f23ff4ef9b9e13783b719cb90376b2548a2f852c6011bae8d01babf6d::pogi {
    struct POGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGI>(arg0, 6, b"POGI", b"Pogi Dog Sui", b"Pogi Dog Sui Coin Meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000045_b302eab5a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

