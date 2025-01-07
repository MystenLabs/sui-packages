module 0xabd9f3b564026fc1249f73ba4e8e8c0983a7d6b7db2c0ce2faea3385ace11741::sdrag {
    struct SDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAG>(arg0, 6, b"SDRAG", b"Sui Dragon", b"Introducing SuiDragon, the blazing hot new meme token taking the crypto world by storm! Inspired by the mythical and powerful dragon, SuiDragon soars into the market as the token of choice for 2024, the auspicious year of the dragon. Website : https://sdrag.xyz Twitter : https://x.com/sdragsui Telegram : https://t.me/sdragsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_22_42_00_090608d0e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

