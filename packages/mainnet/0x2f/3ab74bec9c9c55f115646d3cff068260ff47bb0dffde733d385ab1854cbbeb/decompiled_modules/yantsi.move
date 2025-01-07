module 0x2f3ab74bec9c9c55f115646d3cff068260ff47bb0dffde733d385ab1854cbbeb::yantsi {
    struct YANTSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YANTSI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YANTSI>(arg0, 6, b"YANTSI", b"YanTsi", b"yAntsIAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Yan_297c923818.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YANTSI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANTSI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

