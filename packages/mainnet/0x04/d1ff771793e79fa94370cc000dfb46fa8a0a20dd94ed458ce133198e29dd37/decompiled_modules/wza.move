module 0x4d1ff771793e79fa94370cc000dfb46fa8a0a20dd94ed458ce133198e29dd37::wza {
    struct WZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZA>(arg0, 6, b"WZA", b"Wazaaa", b"Wazaaa, the Meme Coin Killer, is built on the Solana blockchain, offering high-speed transactions and low fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725071437685_5bec5c21a610ee3c1b4cc1d29cea9963_cb6347437c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

