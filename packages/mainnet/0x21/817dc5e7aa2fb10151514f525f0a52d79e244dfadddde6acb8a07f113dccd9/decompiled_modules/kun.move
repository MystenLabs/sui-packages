module 0x21817dc5e7aa2fb10151514f525f0a52d79e244dfadddde6acb8a07f113dccd9::kun {
    struct KUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUN>(arg0, 9, b"KUN", b"KUN LEGEND", b"Kun Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838925737278976000/rrlso-GM_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

