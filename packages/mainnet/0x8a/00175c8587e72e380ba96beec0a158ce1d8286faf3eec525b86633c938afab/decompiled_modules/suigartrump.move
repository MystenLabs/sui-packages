module 0x8a00175c8587e72e380ba96beec0a158ce1d8286faf3eec525b86633c938afab::suigartrump {
    struct SUIGARTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGARTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGARTRUMP>(arg0, 6, b"SUIGARTRUMP", b"Suigar Trump", b"Donald J Trump is now on the fastest Blockchain in Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_18db3d8d7e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGARTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGARTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

