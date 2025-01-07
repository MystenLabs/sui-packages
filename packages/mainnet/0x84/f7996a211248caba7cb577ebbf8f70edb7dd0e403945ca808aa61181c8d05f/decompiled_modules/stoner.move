module 0x84f7996a211248caba7cb577ebbf8f70edb7dd0e403945ca808aa61181c8d05f::stoner {
    struct STONER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONER>(arg0, 6, b"STONER", b"Really High Guy", b"Forgot what we were doing maybe were just too high.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_Rs_LNPYM_400x400_59bb2648a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONER>>(v1);
    }

    // decompiled from Move bytecode v6
}

