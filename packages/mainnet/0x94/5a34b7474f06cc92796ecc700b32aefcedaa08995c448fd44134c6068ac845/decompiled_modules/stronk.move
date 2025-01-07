module 0x945a34b7474f06cc92796ecc700b32aefcedaa08995c448fd44134c6068ac845::stronk {
    struct STRONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRONK>(arg0, 6, b"STRONK", b"Stronk on Sui", x"506f776572207570207769746820245354524f4e4b206f6e20537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Stronk_f491309083.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

