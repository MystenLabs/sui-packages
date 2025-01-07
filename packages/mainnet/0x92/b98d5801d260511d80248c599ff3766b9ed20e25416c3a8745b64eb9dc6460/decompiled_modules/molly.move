module 0x92b98d5801d260511d80248c599ff3766b9ed20e25416c3a8745b64eb9dc6460::molly {
    struct MOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLLY>(arg0, 6, b"Molly", b"Rip Molly ", x"526970204d6f6c6c7920c3a920756d206d656d65636f696e20696e7370697261646f206e6120636f6d6f76656e74652068697374c3b372696120646120656c6566616e7461204d6f6c6c792c2071756520636f6e71756973746f7520636f7261c3a7c3b5657320656d2042616c69206520616cc3a96d2e2043726961646f206e612072656465205375692c206f20526970204d6f6c6c7920c3a9206d61697320646f2071756520756d612073696d706c65732063726970746f6d6f6564613a20c3a920756d2073c3ad6d626f6c6f20646520636f6e736369656e74697a61c3a7c3a36f20616d6269656e74616c2065207072657365727661c3a7c3a36f20616e696d616c2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735425293941.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

