module 0x1d8e68b383a72bdd713693bff8f6b95704754a68b8e8d5347579bcf4c6425b64::groot {
    struct GROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROOT>(arg0, 6, b"GROOT", b"I am Groot", b"I am Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot Groot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_00_50_20_53e3801b17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

