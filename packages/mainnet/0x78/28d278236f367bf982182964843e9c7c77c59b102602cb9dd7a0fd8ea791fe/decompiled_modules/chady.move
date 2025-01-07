module 0x7828d278236f367bf982182964843e9c7c77c59b102602cb9dd7a0fd8ea791fe::chady {
    struct CHADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADY>(arg0, 6, b"CHADY", b"First Chady on Sui", b"First Chady on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/figg_139733a5cd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

