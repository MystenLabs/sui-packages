module 0x24518274c8ded2b22c1e957bd972b04474cc7cf65f8063167c5b83ac85b80992::crocs {
    struct CROCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCS>(arg0, 6, b"CROCS", b"CROC ON SUI STREET", b"SNAP UP ON SUCCESS, WITH CROC ON SUI STREET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_22_00_24_19166db65c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

