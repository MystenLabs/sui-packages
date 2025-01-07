module 0xfe27f649091dbf80ad22b0780461621c4611dc3b499c5dddc51e93668915a85e::emus {
    struct EMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMUS>(arg0, 6, b"EMUS", b"ELON MUSK", b"$EMUS $EMUS  $EMUS  $EMUS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/musk_dfb10837b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

