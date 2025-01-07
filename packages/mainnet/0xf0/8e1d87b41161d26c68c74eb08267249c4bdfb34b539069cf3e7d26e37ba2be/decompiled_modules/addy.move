module 0xf08e1d87b41161d26c68c74eb08267249c4bdfb34b539069cf3e7d26e37ba2be::addy {
    struct ADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDY>(arg0, 6, b"ADDY", b"Add3roll", b"Stay focus, the edge over the competition!! Add3roll gives you that boost you need to make incredible gains. You hold this and your $$$ grows. One to buy in the morning and one to buy mid day..... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ade2_b75889c9a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

