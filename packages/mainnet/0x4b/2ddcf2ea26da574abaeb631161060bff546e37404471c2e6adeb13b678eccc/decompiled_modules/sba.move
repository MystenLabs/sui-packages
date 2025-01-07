module 0x4b2ddcf2ea26da574abaeb631161060bff546e37404471c2e6adeb13b678eccc::sba {
    struct SBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBA>(arg0, 6, b"SBA", b"SuiBear", b"Bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4031_7501abdd85.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

