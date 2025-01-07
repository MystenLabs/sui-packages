module 0xbde4861a07c738e6e0242cdae9556fde7143a82bbc00b3bbf467213eba0c0d5f::memek_aei {
    struct MEMEK_AEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_AEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_AEI>(arg0, 6, b"MEMEKAEI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_AEI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_AEI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_AEI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

