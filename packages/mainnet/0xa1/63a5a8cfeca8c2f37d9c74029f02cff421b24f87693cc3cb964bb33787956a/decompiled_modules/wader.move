module 0xa163a5a8cfeca8c2f37d9c74029f02cff421b24f87693cc3cb964bb33787956a::wader {
    struct WADER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADER>(arg0, 9, b"WADER", b"Wader", b"Info mancing gan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/G37f0TJb/wader-fish-cartoon-422361861.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WADER>(&mut v2, 69000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WADER>>(v1);
    }

    // decompiled from Move bytecode v6
}

