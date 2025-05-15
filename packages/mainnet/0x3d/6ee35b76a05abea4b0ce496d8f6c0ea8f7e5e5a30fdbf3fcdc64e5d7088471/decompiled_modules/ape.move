module 0x3d6ee35b76a05abea4b0ce496d8f6c0ea8f7e5e5a30fdbf3fcdc64e5d7088471::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"ApePoke", b"https://x.com/ApePokerClub Ape poker sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/befb40d7319b04bed908553e4829709a_9f5120ec38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

