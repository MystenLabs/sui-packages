module 0xf3c43a199fb1b1468c2fb6658839b763ebd5e2d2b9d9464dffda3a84b2eef3b6::btcsui {
    struct BTCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCSUI>(arg0, 6, b"BTCSUI", b"BTC on SUI", b"Well Well, this one gonna hit 100k either, lets join the party bro : https.t/me/btconsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_07_17_57_96e8225a92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

