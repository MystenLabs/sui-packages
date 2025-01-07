module 0xeef4fb42bcd440e7a88d2132e633277a663896ba8e7ce65af9e93ce1b9bab7ad::smol {
    struct SMOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOL>(arg0, 6, b"Smol", b"SuiSmol", b"The big things will come in #SMOL on Sui Buy Smol, Hold Smol and wait for Smol go to moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14ok_5d9df41e14.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

