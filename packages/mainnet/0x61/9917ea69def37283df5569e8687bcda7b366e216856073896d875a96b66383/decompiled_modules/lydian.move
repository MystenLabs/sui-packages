module 0x619917ea69def37283df5569e8687bcda7b366e216856073896d875a96b66383::lydian {
    struct LYDIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYDIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYDIAN>(arg0, 6, b"LYDIAN", b"WORLDS FIRST COIN", b"The Lydian Stater was the official coin of the Lydian Empire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lydian_072be9bd12.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYDIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYDIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

