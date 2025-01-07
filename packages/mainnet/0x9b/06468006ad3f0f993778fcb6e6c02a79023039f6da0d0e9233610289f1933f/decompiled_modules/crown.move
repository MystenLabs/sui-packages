module 0x9b06468006ad3f0f993778fcb6e6c02a79023039f6da0d0e9233610289f1933f::crown {
    struct CROWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROWN>(arg0, 6, b"CROWN", b"KING OF THE SEA", x"496e20686f6e6f72206f6620204b494e47204f4620544845205345412026204c494748544e494e4720464541545552452052454c4541534520206f6e20204d4f564550554d50210a446f6e2774206d697373206f7574210a4b696e67206f6620746865205365612063726f776e212020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KING_OF_THE_SEA_0876f72155.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

