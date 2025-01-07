module 0xd72bc0ccc47bbd0adc08e2f2f8ab13741ea381cc7bf8233691f85995f655f6ab::finalsalvation {
    struct FINALSALVATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINALSALVATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINALSALVATION>(arg0, 6, b"FinalSalvation", b"E4C", b"Top mobile app MOBA game & Hottest Rangers NFT collections of in-game avatars with super utilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nwh3_ZJ_Zy_400x400_ccae275c26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINALSALVATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINALSALVATION>>(v1);
    }

    // decompiled from Move bytecode v6
}

