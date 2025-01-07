module 0xd1f082a19a1e80cff09b8a14e2ec795f25bbdd956a67db90b1431b50b8e85db9::suison {
    struct SUISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISON>(arg0, 6, b"SUISON", b"Sui Simpsons", b"Simpsons has become one of the most iconic and influential animations in cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_224110_544_b14367d8b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISON>>(v1);
    }

    // decompiled from Move bytecode v6
}

