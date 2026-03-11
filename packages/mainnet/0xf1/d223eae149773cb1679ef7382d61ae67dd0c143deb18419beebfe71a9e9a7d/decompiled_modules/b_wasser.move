module 0xf1d223eae149773cb1679ef7382d61ae67dd0c143deb18419beebfe71a9e9a7d::b_wasser {
    struct B_WASSER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WASSER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WASSER>(arg0, 9, b"bWASSER", b"bToken WASSER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WASSER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WASSER>>(v1);
    }

    // decompiled from Move bytecode v6
}

