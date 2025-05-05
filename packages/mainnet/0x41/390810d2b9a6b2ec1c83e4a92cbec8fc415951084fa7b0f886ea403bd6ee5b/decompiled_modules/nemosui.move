module 0x41390810d2b9a6b2ec1c83e4a92cbec8fc415951084fa7b0f886ea403bd6ee5b::nemosui {
    struct NEMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMOSUI>(arg0, 6, b"NEMOSUI", b"NEMO", b"NEMO ARRIVES IN SUI IN SEARCH OF HIS FAMILY AND FRIENDS, HELP HIM TRAVEL THIS GREAT OCEAN TO FIND THEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5e5a6f975451ea43d00fa2b921da8a36_ed57eeb4ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

