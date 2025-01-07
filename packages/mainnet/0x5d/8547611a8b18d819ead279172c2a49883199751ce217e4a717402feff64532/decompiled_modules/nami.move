module 0x5d8547611a8b18d819ead279172c2a49883199751ce217e4a717402feff64532::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 6, b"NAMI", b"Suinami", b"$NAMI is here to ride the waves ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zxc9_V86w_400x400_b52bdf36a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

