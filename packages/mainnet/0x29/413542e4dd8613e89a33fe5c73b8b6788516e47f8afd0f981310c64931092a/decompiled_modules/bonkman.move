module 0x29413542e4dd8613e89a33fe5c73b8b6788516e47f8afd0f981310c64931092a::bonkman {
    struct BONKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKMAN>(arg0, 6, b"BONKMAN", b"Only Possible In Sui", b"Only possible on SUIIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_02_24_50_4e3e62c3bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

