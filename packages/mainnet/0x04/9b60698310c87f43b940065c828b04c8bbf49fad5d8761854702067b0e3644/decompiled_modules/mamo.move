module 0x49b60698310c87f43b940065c828b04c8bbf49fad5d8761854702067b0e3644::mamo {
    struct MAMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMO>(arg0, 6, b"MAMO", b"Sui Mamo", b"$MAMO: The legendary leader of the crypto community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021857_d8b999362d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

