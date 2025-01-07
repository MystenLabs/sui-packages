module 0xd6244e9404ad5ee200f8d3db9feeb19fa8970ea1e9268241634db124af525011::mooni {
    struct MOONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONI>(arg0, 9, b"Mooni", b"MoonShot Mascot", b"MoonShot Mascot ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/pPpoMxhKQcjxYzDE?width=400&height=400&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOONI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

