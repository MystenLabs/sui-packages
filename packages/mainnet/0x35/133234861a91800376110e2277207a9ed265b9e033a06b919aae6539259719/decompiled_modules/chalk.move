module 0x35133234861a91800376110e2277207a9ed265b9e033a06b919aae6539259719::chalk {
    struct CHALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHALK>(arg0, 6, b"CHALK", b"SUI CHALK", x"6a7573742061206368616c6b2064756465206f6e200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chalk_sui_COMPRESS_3de1e9eeb5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

