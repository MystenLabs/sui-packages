module 0xfc22e039f08a01b826b5f00f20f405fdf3e529fb08b84ceb68f81b36fbeb8b82::bluff {
    struct BLUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUFF>(arg0, 6, b"BLUFF", b"Bluff Cat", b"Bluffcat - a cool and adorable white cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011719_b8db7ef481.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

