module 0x7c3b9a32d2891149af266b9b289ad4ba01421daf5ed7e952f271e42098c0ec46::the_Lame_chain {
    struct THE_LAME_CHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE_LAME_CHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE_LAME_CHAIN>(arg0, 9, b"TLC", b"the Lame chain", b"onboarindg the masses never. The lame chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/896b40a6-6f54-4602-b20b-fc108e15aaec.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THE_LAME_CHAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE_LAME_CHAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

