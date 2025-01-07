module 0xb00ef773cd4a27aceea59a85e07b68c2e37db997c21f4ee1439ae377c930c6b2::bbdg {
    struct BBDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBDG>(arg0, 6, b"BBDG", b"BOPPY BADGER", b"Digging deep into the meme mines and striking gold. Boppy Badger is all about fun and fortune!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_22_034312799_cde4843ef4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

