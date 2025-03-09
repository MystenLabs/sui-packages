module 0xb204fba60d452a9540df3f635c19168d10bb1e12796d2b30e73e0f221d891a72::sprk {
    struct SPRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRK>(arg0, 9, b"SPRK", b"SuiSpark", b"Ignite innovation, spark the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"file:///C:/Users/PC/Downloads/DALL%C2%B7E%202025-03-09%2013.21.44%20-%20A%20futuristic%20cryptocurrency%20coin%20for%20'SuiSpark'%20($SPRK),%20featuring%20a%20sleek%20metallic%20design%20with%20a%20glowing%20electric%20blue%20and%20orange%20spark%20effect%20in%20the.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPRK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

