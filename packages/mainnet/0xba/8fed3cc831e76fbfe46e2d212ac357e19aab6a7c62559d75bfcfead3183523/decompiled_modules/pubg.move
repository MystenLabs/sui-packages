module 0xba8fed3cc831e76fbfe46e2d212ac357e19aab6a7c62559d75bfcfead3183523::pubg {
    struct PUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUBG>(arg0, 9, b"PUBG", b"PlayerUnkn", b"PUBG: BATTLEGROUNDS is a battle royale that pits 100 players against each other. Players will land, loot, and survive in a shrinking battleground as they outplay their opponents to become the lone survivor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e68aeb0-a528-457a-86b7-0103d9ed47f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

