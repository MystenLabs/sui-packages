module 0x8b013db1c8aece0c63cb11e67ee69fdc4d0b8a4baf286dd85b2b9ac4a694f7b4::dip {
    struct DIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIP>(arg0, 6, b"DIP", b"Dippy", b"Dippy is here on Sui to bring chaos and cash...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001410_dc22fc2e32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

