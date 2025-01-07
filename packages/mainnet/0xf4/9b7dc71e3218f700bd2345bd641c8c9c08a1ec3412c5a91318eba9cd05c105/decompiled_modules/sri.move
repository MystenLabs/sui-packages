module 0xf49b7dc71e3218f700bd2345bd641c8c9c08a1ec3412c5a91318eba9cd05c105::sri {
    struct SRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRI>(arg0, 6, b"SRI", b"SUIRRARI", x"5375692052726172693a2054686520556c74696d617465205374617475732053796d626f6c2e0a457870657269656e63652074686520746872696c6c6f66206578636c75736976697479207769746820537569205272617269", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004224_b7d89cf803.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

