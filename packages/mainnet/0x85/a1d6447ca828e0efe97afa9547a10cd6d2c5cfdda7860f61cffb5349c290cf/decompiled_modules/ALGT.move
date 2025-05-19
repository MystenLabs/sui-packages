module 0x85a1d6447ca828e0efe97afa9547a10cd6d2c5cfdda7860f61cffb5349c290cf::ALGT {
    struct ALGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALGT>(arg0, 6, b"ALGT", b"Aligator", b"Aligator bum bum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSrark36MvVEdDJwpnqqejKhqZ4X1WWzNo9ACEeg91Bej")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

