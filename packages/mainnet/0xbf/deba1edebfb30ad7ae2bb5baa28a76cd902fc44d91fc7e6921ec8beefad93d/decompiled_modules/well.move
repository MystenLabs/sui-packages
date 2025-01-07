module 0xbfdeba1edebfb30ad7ae2bb5baa28a76cd902fc44d91fc7e6921ec8beefad93d::well {
    struct WELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELL>(arg0, 6, b"Well", b"Well", b"Well pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGS355pTxy89ZEfSoNA8DsxPL5C3yGXkDi3A&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WELL>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

