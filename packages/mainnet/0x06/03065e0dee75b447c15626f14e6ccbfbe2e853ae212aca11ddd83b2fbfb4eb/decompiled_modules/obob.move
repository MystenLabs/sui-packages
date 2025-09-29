module 0x603065e0dee75b447c15626f14e6ccbfbe2e853ae212aca11ddd83b2fbfb4eb::obob {
    struct OBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBOB>(arg0, 6, b"OBOB", b"ABOBO", b"ADOBO A FILIPINO DISH GET YOURS 10 PESOS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759182994491.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

