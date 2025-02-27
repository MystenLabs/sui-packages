module 0x318fbdc013692e2541412cfbc8352ed86d51f6240c27b3c166bc139e55997e11::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 9, b"SUIM", b"SUIM Coin", b"The official token of SUIM.Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2de61a4e6b99b0cd0389df0bb13f4d7dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

