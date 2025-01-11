module 0xe7038175d548a3f9f9ee7a2124bb454b2209bed82f3473564feda30e252373e7::saucy {
    struct SAUCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUCY>(arg0, 6, b"SAUCY", b"Sui Sauce", b"Sui networks secret sauce with gains that are finger licking good!!! NFT menu will blow your mind!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6169_9b095eeda5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAUCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

