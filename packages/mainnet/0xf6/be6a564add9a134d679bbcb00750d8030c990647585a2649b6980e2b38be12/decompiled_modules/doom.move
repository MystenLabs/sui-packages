module 0xf6be6a564add9a134d679bbcb00750d8030c990647585a2649b6980e2b38be12::doom {
    struct DOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOOM>(arg0, 6, b"DOOM", b"Dr. Doom by SuiAI", b"'You rush to platitudes like drowning men swarming a lifeboat.. ...Capitalism cannot, will not save you'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Scherm_afbeelding_2025_03_08_om_22_57_38_2715f634d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOOM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

