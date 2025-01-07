module 0x6ce5cd11b81896ff39700636cd00ba74b5159ef90121d3808128763f36c8bf96::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 6, b"CR7", b"C R 7", b"Siuuuuuuuuu!Siuuuuuuuuu!Siuuuuuuuuu!Siuuuuuuuuu!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029604_bc62421431_c6cd67aedf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

