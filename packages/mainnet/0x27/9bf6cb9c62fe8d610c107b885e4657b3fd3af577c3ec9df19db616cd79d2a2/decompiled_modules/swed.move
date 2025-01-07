module 0x279bf6cb9c62fe8d610c107b885e4657b3fd3af577c3ec9df19db616cd79d2a2::swed {
    struct SWED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWED>(arg0, 6, b"SWED", b"SWED GUY", b"Tired of Scam? So are we join the $SWED revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014723_9de15d0043.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWED>>(v1);
    }

    // decompiled from Move bytecode v6
}

