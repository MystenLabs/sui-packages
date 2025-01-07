module 0x2965a4c2569335d9b62930e9864577795bbf483daad5e9d39e67bc52ade6368e::boboonsu {
    struct BOBOONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBOONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBOONSU>(arg0, 9, b"BOBOONSU", b"BoBo Me", b"BoBo is BoBo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26f901d5-9170-4018-9efe-e8e2d0551e66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOONSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBOONSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

