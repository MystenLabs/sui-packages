module 0x2b25b5200f755dd2cdd509ed68a5470724892ba4a195b0703ccc031dad846846::bluefin {
    struct BLUEFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEFIN>(arg0, 6, b"BLUEFIN", b"Bluefin Pepe", b"BlueFin Pepe  The chillest fish in the memeverse. Half legendary bass, half internet frog, all vibes. No roadmap. No utility. Just pure aquatic absurdity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bluefin_Pepe_ad9ecbb3c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

