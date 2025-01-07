module 0x82c95ecc900df1e96a158168c1c3efafa043780eb69dea3206a268dfc828846f::bosi {
    struct BOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSI>(arg0, 6, b"BOSI", b"Beliquor on sui", b"Be liquor, my friend. New era of meme on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/liquer_5b31e7a07a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

