module 0xd2031638fb6582095b49b3b1ecbc9fcecd10b383febdd31b588316e13179a5ce::poe {
    struct POE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POE>(arg0, 6, b"POE", b"Poe The Polar Bear", b"Poe the adorable, lovable Polar Bear!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coinerpfp_02896d5832.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POE>>(v1);
    }

    // decompiled from Move bytecode v6
}

