module 0xf3e79814da366f703f86c88c306f76044f8007f102a4aa098c39589b1d36f61a::seacat {
    struct SEACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEACAT>(arg0, 6, b"SEACAT", b"$SEA CAT (CTO)", b"Together on a journey into the vast expanse of the Sui Ocean where legends and mysteries wait to unraveled.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_f6550c764d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

