module 0x2ab4c6e3c9faaa5950122a30a5fa779c6a206fa502ae8f83c9a4e09ed3093851::ruslon {
    struct RUSLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSLON>(arg0, 6, b"RUSLON", b"Ruslon Skamolovskiy", b"A Lambo is not a luxury it is a necessity and one day everyone will have the opportunity to own a Lambo through Ruslon Skamolovskiy!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723448449905_16e79e148218c0afc8b81775c66cf2f1_56a93e182d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

