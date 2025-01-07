module 0x6ad09afb3f846e0ae5a45491e9b0993ad8f48a342018e59241df759c640d40c9::sui_pepe {
    struct SUI_PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PEPE>(arg0, 9, b"Sui Pepe", b"Sui Pepe", b"Pepe Is meme , now on sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843802344854827011/Pri-X0EA.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_PEPE>(&mut v2, 440000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

