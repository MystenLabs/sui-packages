module 0xed39f75ff4c855fb19766a646b8411c0cf2d14e341bcc4b9f425b6196e9937f5::wara {
    struct WARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARA>(arg0, 9, b"WARA", b"Wara.Sui", b"https://x.com/0xWara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1834658254544154624/YJQl1hDF_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WARA>(&mut v2, 9999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

