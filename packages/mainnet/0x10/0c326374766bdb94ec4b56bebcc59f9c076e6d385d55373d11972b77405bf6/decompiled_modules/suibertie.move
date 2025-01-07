module 0x100c326374766bdb94ec4b56bebcc59f9c076e6d385d55373d11972b77405bf6::suibertie {
    struct SUIBERTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERTIE>(arg0, 6, b"SuiBertie", b"Bertie", b"Bertie is the fastest tortoise in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_13_05_12_04_f5be116cfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

