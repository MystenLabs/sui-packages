module 0xc56814f08b13b9287f5e11ffa40a295e11061f5a28ec8acb877290b6c43dd48f::trm {
    struct TRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRM>(arg0, 6, b"TRM", b"Sui TermiAI", b"Generally you will see robots on land, but not with $TRM, its natural habitat is in the sea, sometimes it is more comfortable on the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250507_233729_62dbcebc99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

