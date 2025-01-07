module 0x33a9d6d7d023777f5bdadbd0dc5a3bbccdff1fcfcbe2959421b236f2b3279d60::swoof {
    struct SWOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOF>(arg0, 6, b"SWOOF", b"SUIWOOF", b"Woof! Woof! SuiWoof is a blue doge build , the community-owned meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TP_6_S_Ym_Rs_400x400_0521fc5181.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

