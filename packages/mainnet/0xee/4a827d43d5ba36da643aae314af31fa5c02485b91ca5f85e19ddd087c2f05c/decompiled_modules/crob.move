module 0xee4a827d43d5ba36da643aae314af31fa5c02485b91ca5f85e19ddd087c2f05c::crob {
    struct CROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROB>(arg0, 6, b"CROB", b"CROBSUI", b"Witness the rise of Shellionaires in a place where #FFTB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ri_O_Pse_ZH_400x400_ffed2a0901.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROB>>(v1);
    }

    // decompiled from Move bytecode v6
}

