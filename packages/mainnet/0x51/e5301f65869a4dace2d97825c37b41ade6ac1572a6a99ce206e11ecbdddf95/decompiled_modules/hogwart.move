module 0x51e5301f65869a4dace2d97825c37b41ade6ac1572a6a99ce206e11ecbdddf95::hogwart {
    struct HOGWART has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOGWART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOGWART>(arg0, 6, b"Hogwart", b"Hogwart", b"Protecting the meme community from rug pulls, inflation and bad actors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmZpEYoYpJ1bbV9MfLQR9rozKiBxNT6LK3eh9K6dji7Jru?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOGWART>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOGWART>>(v2, @0xafe7427168157cf296ae416c187dd106161a50dc9cdc7d511cb31b4a87efa219);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOGWART>>(v1);
    }

    // decompiled from Move bytecode v6
}

