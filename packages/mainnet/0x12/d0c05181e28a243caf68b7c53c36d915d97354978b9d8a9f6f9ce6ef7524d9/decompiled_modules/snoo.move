module 0x12d0c05181e28a243caf68b7c53c36d915d97354978b9d8a9f6f9ce6ef7524d9::snoo {
    struct SNOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOO>(arg0, 6, b"Snoo", b"SNOO", b"In the vast universe, $Snoo is a brave little alien on a noble mission: to spread wealth and happiness among the stars. With advanced technology from his home planet, he travels deep into the Sui blockchain to help humans achieve good fortune in a fun way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241101_212908_515_fa1862ae2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

