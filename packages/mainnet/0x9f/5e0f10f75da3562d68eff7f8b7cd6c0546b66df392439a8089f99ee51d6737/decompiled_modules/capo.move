module 0x9f5e0f10f75da3562d68eff7f8b7cd6c0546b66df392439a8089f99ee51d6737::capo {
    struct CAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 9, b"CAPO", b"Capo '' The Mafia on Sui ''", b"I'm gonna make him an offer he can't refuse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/100fa4849a33d6be81fc78192497989ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

