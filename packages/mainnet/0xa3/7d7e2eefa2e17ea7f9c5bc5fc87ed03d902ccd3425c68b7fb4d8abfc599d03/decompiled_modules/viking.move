module 0xa37d7e2eefa2e17ea7f9c5bc5fc87ed03d902ccd3425c68b7fb4d8abfc599d03::viking {
    struct VIKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIKING>(arg0, 6, b"VIKING", b"VIKING$", b"\"Viking $uiFaring Explorations\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JPG_47c88c0037.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

