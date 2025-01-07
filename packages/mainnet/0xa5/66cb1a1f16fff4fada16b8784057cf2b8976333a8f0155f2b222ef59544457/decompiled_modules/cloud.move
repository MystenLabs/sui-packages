module 0xa566cb1a1f16fff4fada16b8784057cf2b8976333a8f0155f2b222ef59544457::cloud {
    struct CLOUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUD>(arg0, 6, b"CLOUD", b"CloudCoin", b"Welcome to the exciting world of CloudCoin, the funniest and most energetic meme cryptocurrency in the digital space! Are you ready for a trip to the moon as we explore the heights of the cloud?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TP_Ii5_By6_400x400_00722b6541.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

