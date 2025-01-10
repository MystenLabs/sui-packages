module 0x89156d7cc4f83e3228d8fb1ef15067c0adf0530dde23cc36d69cffc62048cac6::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 6, b"MOB", b"MOB AI", b"MOB AI AGENT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CWOA_go_400x400_976e064c1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

