module 0xa04815c81b309cf20234bd82eea623e74178ce234a61d2bf4ea10996904f66a6::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 6, b"PONKE", b"SUIPONKE", b"Hi Im Ponke On Sui! A degenerate gambler that doesnt get along with just anyone but I have a lot of friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uf1y_SUC_1_400x400_6c92ba2e4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

