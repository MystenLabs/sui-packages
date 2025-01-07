module 0x6cc153a34b0ee7aabf3f1e4a31e5032e6bb3b131f7e58982bee81097dcd010af::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 9, b"PIGU", b"PIGU", b"PIGU ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSksYLP_Xnq6Y-vFV5_n5w3bhXkG0TxaDxXpQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

