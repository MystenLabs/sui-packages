module 0xa5b01f77c29408aa6f90143d3f38218f28a089caac8ee3d48437ca26a7b807bd::prett {
    struct PRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRETT>(arg0, 6, b"PRETT", b"Prett the Penguin", b"Prett, Brett's long lost cousin residing in Antarctica has arrived on Sui to chill and win!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xxx_39e149cb94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

