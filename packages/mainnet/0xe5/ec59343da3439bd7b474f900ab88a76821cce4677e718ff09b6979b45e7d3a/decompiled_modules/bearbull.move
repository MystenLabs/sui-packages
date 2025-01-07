module 0xe5ec59343da3439bd7b474f900ab88a76821cce4677e718ff09b6979b45e7d3a::bearbull {
    struct BEARBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARBULL>(arg0, 9, b"BearBuLL", b"Layer 5 ", b"Ecosystem big Magnet project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/07265cbd02fb14ef8fd92b1228e9d14eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEARBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

