module 0xc2d18518198a395233a0e5e557d67310dd7f5bf8606c4f4f7f8f1776d344bf0e::BBBCAT {
    struct BBBCAT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BBBCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BBBCAT>>(0x2::coin::mint<BBBCAT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BBBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBBCAT>(arg0, 0, b"BBBCAT", b"BBB", b"super BBB coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/BB6m8si.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBBCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBBCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

