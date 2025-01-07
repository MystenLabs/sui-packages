module 0xad8b5a692c5116ac125f98703362fd558328a57836072bd0c78b9189a92a0691::sally {
    struct SALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALLY>(arg0, 6, b"SALLY", b"Sally", b"The most adorable aquatic pet just landed on Sui! Grab a bad of $SALLY and let's send this salamander from the ocean to the moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M_LOGO_2_ae2becc5a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

