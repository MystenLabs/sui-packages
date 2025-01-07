module 0x933ba72c57aedae4cd5ba98d863c0897d87430a90bd182757527b61d26e2c47a::goldfish {
    struct GOLDFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDFISH>(arg0, 6, b"GOLDFISH", b"GOLDEN FISH", b"Golden fish is good narative on sui meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3903_ec0376b804.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

