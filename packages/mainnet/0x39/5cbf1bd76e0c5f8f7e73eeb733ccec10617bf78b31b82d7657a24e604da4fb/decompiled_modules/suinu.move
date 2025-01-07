module 0x395cbf1bd76e0c5f8f7e73eeb733ccec10617bf78b31b82d7657a24e604da4fb::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 6, b"SUINU", b"Sui inu", b"Sui inu us live ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029182_0339b6c0a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

