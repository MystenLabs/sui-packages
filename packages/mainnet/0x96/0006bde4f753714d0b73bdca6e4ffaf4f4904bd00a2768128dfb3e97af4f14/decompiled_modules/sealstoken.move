module 0x960006bde4f753714d0b73bdca6e4ffaf4f4904bd00a2768128dfb3e97af4f14::sealstoken {
    struct SEALSTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALSTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALSTOKEN>(arg0, 6, b"Sealstoken", b"seals and dogs", b"Welcome to the next generation of coin memes, this is a seal and a dog the cutest ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A344_AE_21_17_D3_4807_9_C61_B572_FF_8_B1756_3ebf106b72.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALSTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALSTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

