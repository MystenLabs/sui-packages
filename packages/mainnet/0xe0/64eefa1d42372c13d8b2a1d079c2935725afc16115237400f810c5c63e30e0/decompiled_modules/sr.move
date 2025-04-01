module 0xe064eefa1d42372c13d8b2a1d079c2935725afc16115237400f810c5c63e30e0::sr {
    struct SR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR>(arg0, 9, b"SR", b"SARA", b"5 YEAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2f04ad2f22a3bee568dc59b1e4d3706cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

