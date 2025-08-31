module 0x1169de4c57e2a510abe0c102a60c9d11902de977deb47479f519286f3c5e1a7e::Frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 9, b"FROG", b"Frog", b"frog gorf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzsznMqWoAARXGb?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

