module 0xeb204224a2b6f830368c7b38f9f7db2ee996d8f28f7e09e4f0c846857684f8e4::pigusui {
    struct PIGUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGUSUI>(arg0, 9, b"PIGUSUI", b"PIGUSUI", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtbrZDFmxMkN4yqMni-2ChEysFgtWRc6wsrA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGUSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGUSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

