module 0xb881108b5459c137eb4eb67ee8e26b1c251fac53563a81b970e9acc9f43048cb::moh {
    struct MOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOH>(arg0, 6, b"MOH", b"Mohammedsala", b"$MOH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_01_00_36_d226a5a416.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

