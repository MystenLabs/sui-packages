module 0xdb44e246101c566409e179903d7cbfdb4089d2a4b2b740674107d8f48ddf93d9::pubg {
    struct PUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUBG>(arg0, 9, b"PUBG", b"PlayerUnkn", b"PUBG: BATTLEGROUNDS is a battle royale that pits 100 players against each other. Players will land, loot, and survive in a shrinking battleground as they outplay their opponents to become the lone survivor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/891f945b-ad47-45f1-9b4d-4445041a6c58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

