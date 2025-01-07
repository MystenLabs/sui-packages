module 0x8bc12cb71124cd95fef2ae32606a4a67201b9c6afa3aad09ea5cb63b3a117c27::shitcoin {
    struct SHITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITCOIN>(arg0, 6, b"SHITCOIN", b"SHIT COIN ON SUI", b"Shit coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f6fa92d5ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

