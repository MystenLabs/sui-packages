module 0x7c4aa47e3b0da1a0cf49d114ee6074911d3d7f437c3fbf3125d558241e29292e::shrktnk {
    struct SHRKTNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRKTNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRKTNK>(arg0, 6, b"Shrktnk", b"Shark tank", b"Shark tank on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029236_165db4d612.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRKTNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRKTNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

