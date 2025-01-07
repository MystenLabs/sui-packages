module 0xf46ea0147e82bfadfd9d8a6a652e7be34f9e92a06dcf0936b4ff1ea8e4abdfcd::rain {
    struct RAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIN>(arg0, 6, b"RAIN", b"[RAIN]", b"Born in Kitana's former world of Edenia, Rain was smuggled away from the realm as a small child shortly after Shao Kahn's take over. Thousands of years later he resurfaced, his allegiance now belonging to Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_14_001236_5103feb979.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

