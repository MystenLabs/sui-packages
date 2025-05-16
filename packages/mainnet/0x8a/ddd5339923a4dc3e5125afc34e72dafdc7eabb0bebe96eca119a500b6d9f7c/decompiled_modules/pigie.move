module 0x8addd5339923a4dc3e5125afc34e72dafdc7eabb0bebe96eca119a500b6d9f7c::pigie {
    struct PIGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGIE>(arg0, 6, b"PIGIE", b"PIGIE SUI", b"Pigie New meta on memesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqsvg4nqtupamsppnha65j6ibbyybfzbkm37xwdjvidu6twovdu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIGIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

