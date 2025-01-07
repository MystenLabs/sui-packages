module 0xb0007784d5a08dc94ffd683be2bf14a771bb097b927c355b55e86810f1b07092::peaches {
    struct PEACHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACHES>(arg0, 6, b"PEACHES", b"Sui Peaches", b"Sui  peaches is Dave Portnoys dog, the first charity token on sui chain saving all the pups in the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEACHES_111bb705b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACHES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACHES>>(v1);
    }

    // decompiled from Move bytecode v6
}

