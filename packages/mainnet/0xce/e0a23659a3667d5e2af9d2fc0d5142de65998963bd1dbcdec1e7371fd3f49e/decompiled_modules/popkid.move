module 0xcee0a23659a3667d5e2af9d2fc0d5142de65998963bd1dbcdec1e7371fd3f49e::popkid {
    struct POPKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPKID>(arg0, 6, b"POPKID", b"PopKid", b"Meet $POPKID, the adorable and hilarious meme that's taking the SUI ecosystem by storm! Featuring a cartoon boy with his mouth wide open and eyes sparkling with excitement, $POPKID is here to spread joy and laughter. Inspired by the iconic \"SUCCESS KID\" meme, this delightful character is perfect for anyone looking to add a touch of fun to their day. Get ready to share the smiles and embrace the meme magic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_14_09_06_eb826764b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPKID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPKID>>(v1);
    }

    // decompiled from Move bytecode v6
}

