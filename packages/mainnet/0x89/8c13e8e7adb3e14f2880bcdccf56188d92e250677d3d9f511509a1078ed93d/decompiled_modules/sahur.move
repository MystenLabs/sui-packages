module 0x898c13e8e7adb3e14f2880bcdccf56188d92e250677d3d9f511509a1078ed93d::sahur {
    struct SAHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHUR>(arg0, 6, b"SAHUR", b"Tung Tung Tung Sahur", b"Tung tung tung tung tung tung tung tung tung sahur. A terrifying anomaly that only comes out at Sahoor. It is said that if someone is called for Sahoor three times and does not answer, then this creature comes to your house. Ooh, so scary! This tung tung usually makes a sound like a gong hitting a baton; Tung tung tung tung. Share it with your friends who find it difficult to wake up for Sahoor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2087_117c9087ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAHUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

