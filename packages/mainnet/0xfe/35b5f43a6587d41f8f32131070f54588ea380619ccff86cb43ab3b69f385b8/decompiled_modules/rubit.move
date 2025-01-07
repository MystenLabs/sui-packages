module 0xfe35b5f43a6587d41f8f32131070f54588ea380619ccff86cb43ab3b69f385b8::rubit {
    struct RUBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBIT>(arg0, 6, b"RubIT", b"BIGCLIT", b"Make the king of the sea wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241030_155745_aa2530621d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

