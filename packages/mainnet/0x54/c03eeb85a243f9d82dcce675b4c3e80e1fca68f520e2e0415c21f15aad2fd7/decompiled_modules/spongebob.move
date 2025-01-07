module 0x54c03eeb85a243f9d82dcce675b4c3e80e1fca68f520e2e0415c21f15aad2fd7::spongebob {
    struct SPONGEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGEBOB>(arg0, 6, b"SPONGEBOB", b"Spongebob", b"SpongeBob is a cheerful character who lives in a pineapple under the sea and brings joy with his quirky adventures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xxxxxx_af8b845e67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGEBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

