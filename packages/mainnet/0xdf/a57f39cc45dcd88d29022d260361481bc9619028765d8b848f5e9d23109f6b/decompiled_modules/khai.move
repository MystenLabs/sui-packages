module 0xdfa57f39cc45dcd88d29022d260361481bc9619028765d8b848f5e9d23109f6b::khai {
    struct KHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAI>(arg0, 6, b"KHAI", b"KittenHaimer", b"KHAI created a revolutionary digital currency that is designed for simplicity, security, and accessibility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GARFIELD_7702ca12a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

