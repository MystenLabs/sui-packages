module 0x806ed489f65bdbdf18545d3ae3721c951a60670deb903f4e9bac59490e553745::capys {
    struct CAPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYS>(arg0, 6, b"CAPYS", b"SUI CAPYS", b"SUICAPYS was the first NFT project launched by SUI in 2022, and we are here to bring back the greatness of SUICAPYS $CAPYS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967350384.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

