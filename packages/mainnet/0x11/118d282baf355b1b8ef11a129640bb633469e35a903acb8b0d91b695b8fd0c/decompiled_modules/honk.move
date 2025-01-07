module 0x11118d282baf355b1b8ef11a129640bb633469e35a903acb8b0d91b695b8fd0c::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 9, b"HONK", b"Honkey", b"Honk is a playful, meme-based token on the SUI blockchain, offering fast and secure transactions. It brings humor and fun to DeFi, making crypto more entertaining for its vibrant community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1798214592801460224/EVPdRjnD.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HONK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

