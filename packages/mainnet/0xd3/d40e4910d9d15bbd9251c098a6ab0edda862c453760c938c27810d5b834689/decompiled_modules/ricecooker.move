module 0xd3d40e4910d9d15bbd9251c098a6ab0edda862c453760c938c27810d5b834689::ricecooker {
    struct RICECOOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICECOOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICECOOKER>(arg0, 6, b"Ricecooker", b"Rice Cooker", b"Rice cooker you cant afford", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9208_5ee47587a4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICECOOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICECOOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

