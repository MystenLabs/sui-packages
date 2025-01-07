module 0xb77410c3d60d0045d931da38050ba70d53af527ed1c16ca605d7aa54c3e738c::mnstr {
    struct MNSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNSTR>(arg0, 6, b"Mnstr", b"Monstergo", b"Game to earn First sui Web3 earn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054604_6023494235.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

