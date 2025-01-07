module 0xfa713b4b0fc7da09b123ef7519e5770c7e86705964f680b690672221a620ce39::bonks {
    struct BONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKS>(arg0, 6, b"BONKS", b"SUI Bonk", b"Get ready to bonk your way to crypto fame with $SUIBONK on the Sui blockchain! This meme coin combines the playful spirit of the Bonk meme with the innovative power of Sui, offering a fun and exciting way to engage with the crypto community. Whether youre here for the laughs or the tech, $SUIBONK is your ticket to the next big thing in blockchain fun! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bonksui_7d3d25dc7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

