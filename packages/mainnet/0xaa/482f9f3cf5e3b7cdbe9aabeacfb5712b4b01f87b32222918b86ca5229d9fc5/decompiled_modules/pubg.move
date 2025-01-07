module 0xaa482f9f3cf5e3b7cdbe9aabeacfb5712b4b01f87b32222918b86ca5229d9fc5::pubg {
    struct PUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUBG>(arg0, 9, b"PUBG", b"PlayerUnkn", b"PUBG: BATTLEGROUNDS is a battle royale that pits 100 players against each other. Players will land, loot, and survive in a shrinking battleground as they outplay their opponents to become the lone survivor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bf0669e-9b3b-4f62-8626-bcf6b06cc1a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

