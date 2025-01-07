module 0xd85f7b4f12ac27378f9cb96c74613da3963557664342305365e0001b9749d1f1::catdogs {
    struct CATDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDOGS>(arg0, 6, b"CATDOGS", b"CATDOG WITH AI", b"PUFF Best Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Instagram_Viral_Image_AI_Cat_Dog_1680332724335_1680332736162_1680332736162_98dc50d9b3.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

