module 0xf21a301eb8a7a6b73f6046f1234c1fd109f8ba53cda98672fdc83a2266b14329::boysclub {
    struct BOYSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSCLUB>(arg0, 6, b"BOYSCLUB", b"The Boys Club", b"On the Sui chain, the Boys Club token emerged as a tribute to Matt Furies iconic Boys Club comic. Crafted by fans, its upon the humor and camaraderie of Pepe, Andy, Wolf, and Brett.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_21_47_41_2d0bd78d3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSCLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYSCLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

