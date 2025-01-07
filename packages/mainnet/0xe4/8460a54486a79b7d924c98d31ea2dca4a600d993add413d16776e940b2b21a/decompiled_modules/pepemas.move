module 0xe48460a54486a79b7d924c98d31ea2dca4a600d993add413d16776e940b2b21a::pepemas {
    struct PEPEMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMAS>(arg0, 6, b"PEPEMAS", b"PEPEXMAS", b"PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_05_02_49_36_610b6c7452.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

