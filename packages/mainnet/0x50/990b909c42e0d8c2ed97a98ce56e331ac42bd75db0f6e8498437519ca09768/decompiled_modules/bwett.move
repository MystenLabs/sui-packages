module 0x50990b909c42e0d8c2ed97a98ce56e331ac42bd75db0f6e8498437519ca09768::bwett {
    struct BWETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWETT>(arg0, 6, b"BWETT", b"SUI BWETT", b"$BWETT just a lil fwog's best friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bwett_d7433551aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

