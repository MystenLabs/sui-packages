module 0x61aceb8fbb31f86dd19a54e7f8e8ae6c30c02bde45f87c0e35aab3bfbc5f9532::memefi {
    struct MEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFI>(arg0, 9, b"MEMEFI", b"MEME FI", b"MemeFi is all you could and couldn't dream about a Web3 PvP & PvE game soaked in meme sauce. Fight, rampage and loot tokens on your way to glory! In MemeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/038fde2f-1e59-43ae-80fc-dcedf63c58a9-1000015976.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

