module 0x9dd255478c3cb19937fe72903d2dd56a8226160049ee7b3aecf37a59c0ab2833::moola {
    struct MOOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOLA>(arg0, 6, b"MOOLA", b"MemeMoola", b"Join the Mememoola movement and be part of the fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/26971207_3dad_4cf4_8edb_02d46070e027_ae6af17e71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

