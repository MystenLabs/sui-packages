module 0xb2dfd4e861142490eaa05ca55499c05b6c7da9e4758825ba2038efb36657c703::suibainu {
    struct SUIBAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAINU>(arg0, 6, b"SUIBAINU", b"SUIBA INU", b"SHIBA INU on SUI Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBA_a50834c7b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

