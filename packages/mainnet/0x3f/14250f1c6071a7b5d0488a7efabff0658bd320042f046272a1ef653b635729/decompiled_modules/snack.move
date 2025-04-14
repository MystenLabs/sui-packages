module 0x3f14250f1c6071a7b5d0488a7efabff0658bd320042f046272a1ef653b635729::snack {
    struct SNACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNACK>(arg0, 9, b"SNACK", b"SnackFi", x"412067616d69666965642066696e616e636520746f6b656e2074686174207265776172647320796f7520666f72206e6f74206f766572656174696e672e204c696e6b65642077697468206669746e65737320616e64206865616c746820747261636b696e6720617070732c20534e41434b207475726e732073656c662d636f6e74726f6c20696e746f2070726f6669742e204561726e20746f6b656e73206279206d61696e7461696e696e67206865616c7468792068616269747320e280942077656c6c6e657373206d65657473207765616c74682e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cc56d2435050d085af567100f7660753blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

