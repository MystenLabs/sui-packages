module 0xb3701cbe67ad061b63da13c2675d91b8bca6cdb96c72087d2af10ba8aaa06b6f::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"Suispicious", x"54686520535549207363656e65207365656d73206b696e64612053554953207269676874206e6f77e280a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730938679804.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

