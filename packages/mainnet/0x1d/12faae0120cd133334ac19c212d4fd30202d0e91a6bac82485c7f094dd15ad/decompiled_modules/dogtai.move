module 0x1d12faae0120cd133334ac19c212d4fd30202d0e91a6bac82485c7f094dd15ad::dogtai {
    struct DOGTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGTAI>(arg0, 6, b"DOGTAI", b"Dog Translator AI by SuiAI", b"Ever wondered what your dog is REALLY thinking?.With the Dog Translator Ai, you can finally decode those barks and growls into actual words!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000021376_34fe899994.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

