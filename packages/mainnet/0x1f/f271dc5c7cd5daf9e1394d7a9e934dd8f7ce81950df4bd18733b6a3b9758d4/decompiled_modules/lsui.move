module 0x1ff271dc5c7cd5daf9e1394d7a9e934dd8f7ce81950df4bd18733b6a3b9758d4::lsui {
    struct LSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSUI>(arg0, 6, b"LSUI", b"LAPRAS SUI ($LSUI)", b"$LSUI is a #Meme coin of #Sui blockchain. Let's make dream come true with #LSUI $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_148ee44812.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

