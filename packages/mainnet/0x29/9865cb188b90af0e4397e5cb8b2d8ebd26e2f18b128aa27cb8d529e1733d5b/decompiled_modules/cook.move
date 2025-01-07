module 0x299865cb188b90af0e4397e5cb8b2d8ebd26e2f18b128aa27cb8d529e1733d5b::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"COOK", b"Let Him Cook Now", x"49276d207469726564206f66206265696e67207065727365637574656420666f72206d7920737472656e67746873202d20796f752070656f706c652073686f756c64206265207468616e6b696e67204368726973742074686174204920616d2077686f204920616d2120596f75206e656564206d6520746f207361766520796f75212121204920616d20746865206f6e6c79206f6e652077686f20706f737369626c792063616e2e2e2e0a0a546865792073686f756c642068617665206e65766572206c6574206d6520636f6f6b2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOLZIES_cf74be8a09.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

