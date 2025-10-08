module 0x37b6e8baac31fc6134d903a773ebdda3e7ebdf24ff1952d99e1a3a1f9896db01::edolph0882 {
    struct EDOLPH0882 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOLPH0882, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOLPH0882>(arg0, 18, b"EDOLPH0882", b"Electric Dolphin #0882", b"High-voltage aquatic cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/electric-dolphin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDOLPH0882>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOLPH0882>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

