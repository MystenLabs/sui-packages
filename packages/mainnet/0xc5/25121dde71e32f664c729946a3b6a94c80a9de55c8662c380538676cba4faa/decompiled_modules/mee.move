module 0xc525121dde71e32f664c729946a3b6a94c80a9de55c8662c380538676cba4faa::mee {
    struct MEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEE>(arg0, 6, b"MEE", b"MFERSSUI", b"$MEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M_Yff_W4_JO_400x400_065898e143.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

