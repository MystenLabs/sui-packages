module 0xdd413800f6134a1cf4830e8be8c2454ee7cca2b9033e392cf59a1f5984a3cd96::silver {
    struct SILVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12756-BOSfO14dCKHcGnXrlsLgFFFoz91AFh.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12756-BOSfO14dCKHcGnXrlsLgFFFoz91AFh.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SILVER>(arg0, 9, b"SILVER", b"Sui silver", x"5375692073696c766572e2808b", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILVER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILVER>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SILVER>>(0x2::coin::mint<SILVER>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

