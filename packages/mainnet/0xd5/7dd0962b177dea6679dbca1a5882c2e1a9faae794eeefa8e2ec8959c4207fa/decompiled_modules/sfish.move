module 0xd57dd0962b177dea6679dbca1a5882c2e1a9faae794eeefa8e2ec8959c4207fa::sfish {
    struct SFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFISH>(arg0, 6, b"SFISH", b"Staring Fish", b"In the Sui Ocean, a fish with a famously wide-eyed stare went viral. Its comically shocked expression became a popular meme for the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dwt5_Blxl_400x400_88d5210b16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

