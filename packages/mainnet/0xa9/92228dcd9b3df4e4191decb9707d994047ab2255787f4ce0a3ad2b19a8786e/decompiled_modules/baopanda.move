module 0xa992228dcd9b3df4e4191decb9707d994047ab2255787f4ce0a3ad2b19a8786e::baopanda {
    struct BAOPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAOPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAOPANDA>(arg0, 6, b"BAOPanda", b"BAO Panda", b"Bao Li and Qing Bao: A New Chapter of Hope for Giant Pandas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_J976ho4_400x400_7ce3c96ac4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAOPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAOPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

