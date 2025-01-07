module 0xd569771b82165bf7bfef25f0e9a6e8d42012a0939883cc2811c5ffc06ee10084::sbcc {
    struct SBCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBCC>(arg0, 6, b"SBCC", b"Strawberry Cheesecake", b"A decentralized recipe for strawberry cheesecake, hosted forever on Arweave ArDrive. Buy if you want to taste it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sbcc_380d46e565.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

