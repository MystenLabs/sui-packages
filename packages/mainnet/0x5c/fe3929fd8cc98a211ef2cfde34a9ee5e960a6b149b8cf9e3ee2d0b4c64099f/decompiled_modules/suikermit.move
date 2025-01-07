module 0x5cfe3929fd8cc98a211ef2cfde34a9ee5e960a6b149b8cf9e3ee2d0b4c64099f::suikermit {
    struct SUIKERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKERMIT>(arg0, 9, b"SUIKERMIT", b"Sui Kermit CTO", b"kermit Telegram : https://t.me/SuiKermit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844387261472964609/g-wT6PpF.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKERMIT>(&mut v2, 466000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKERMIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

