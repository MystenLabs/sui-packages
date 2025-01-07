module 0xfe79493605f2f239d1fcc2b12c45ad6b0d3d0db71ffefc6830e0c269fac92dd4::peb {
    struct PEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEB>(arg0, 6, b"PEB", b"Pebble", b"Meet Pebble! He might be small, but he's got big stone-cold meme energy!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peb_0b695d4328.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

