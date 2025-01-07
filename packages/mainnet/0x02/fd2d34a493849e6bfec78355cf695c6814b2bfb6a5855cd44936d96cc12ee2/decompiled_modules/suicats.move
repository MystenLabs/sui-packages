module 0x2fd2d34a493849e6bfec78355cf695c6814b2bfb6a5855cd44936d96cc12ee2::suicats {
    struct SUICATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATS>(arg0, 9, b"SUICATS", b"Sui Cats", b"Cats Is Meme , now On Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844190132401995779/Y2BzKmot.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICATS>(&mut v2, 440000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

