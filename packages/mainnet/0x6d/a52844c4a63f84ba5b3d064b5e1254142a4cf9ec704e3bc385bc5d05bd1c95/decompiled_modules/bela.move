module 0x6da52844c4a63f84ba5b3d064b5e1254142a4cf9ec704e3bc385bc5d05bd1c95::bela {
    struct BELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELA>(arg0, 6, b"BELA", b"SUI BELLA", b"SUI Bella ($BELA) is a community-driven cryptocurrency on the SUI Network, designed to empower creators to sell photos, art, and exclusive content while distributing revenue to token holders. Combining innovation with simplicity, $BELA creates a seamless platform for creative expression and passive income, redefining how art and crypto connect.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/belllaaaaa_2f4c18baa1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELA>>(v1);
    }

    // decompiled from Move bytecode v6
}

