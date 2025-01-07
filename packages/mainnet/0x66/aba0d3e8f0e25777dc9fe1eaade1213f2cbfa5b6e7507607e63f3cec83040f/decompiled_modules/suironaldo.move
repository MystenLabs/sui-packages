module 0x66aba0d3e8f0e25777dc9fe1eaade1213f2cbfa5b6e7507607e63f3cec83040f::suironaldo {
    struct SUIRONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRONALDO>(arg0, 6, b"SuiRonaldo", b"SuiCR7", b"Messi fans stay away! SUUIIIII!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo3_06a0cef17b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRONALDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRONALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

