module 0xa2c0d690f34376142d3b5e818734d51190c1d75b1db0564effc502f690a7640b::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"SHIBCOIN", b"Official Twitter of the Shiba Inu Ecosystem $SHIB, $LEASH, $BONE, #SHIBOSHIS, #SHEBOSHIS and the awaited $TREAT! #TreatYourself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x1e3e191cb950a0b9b74390b6a8a20f320f0ec4ce_08fddd3913.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

