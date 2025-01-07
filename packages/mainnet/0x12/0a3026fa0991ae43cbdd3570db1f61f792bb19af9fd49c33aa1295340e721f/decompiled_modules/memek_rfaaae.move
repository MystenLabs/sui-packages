module 0x120a3026fa0991ae43cbdd3570db1f61f792bb19af9fd49c33aa1295340e721f::memek_rfaaae {
    struct MEMEK_RFAAAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFAAAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFAAAE>(arg0, 6, b"MEMEKRFAAae", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFAAAE>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFAAAE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFAAAE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

