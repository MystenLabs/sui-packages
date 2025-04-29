module 0xba786234f7fa1da1458daee1782fe04060d4d8ab35cac612fcd808610e2f9b6a::apeconomy {
    struct APECONOMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: APECONOMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APECONOMY>(arg0, 6, b"Apeconomy", b"APECONOMY", x"5374726f6e6720417065636f6e6f6d792c2041706573205374726f6e6720546f676574686572207468616e20657665722e20436861727420676f2075702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apeconomy_logo_ea32d53f71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APECONOMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APECONOMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

