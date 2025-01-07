module 0x9102316cab60307a6b40f6ed9a0716e51cca548d15e43dda3e9cf5dc802a9b05::tigerwif {
    struct TIGERWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERWIF>(arg0, 6, b"TigerWif", b"Tiger Wif Hat", b"Tiger Wif Hat movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fwefwefw_8713804d6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGERWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

