module 0x8213bbf912895ebd7f5c67d83b9251705f10c9bdd8b6a8857a937df631768b7e::hopcatsui {
    struct HOPCATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCATSUI>(arg0, 6, b"HopCatSUI", b"HopCat", b"First cat on Hop Fun Trade on Sui using Moonlite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730995482336.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCATSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCATSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

