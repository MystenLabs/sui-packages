module 0x6652c628755a6c8d5d82823e7836f9421ad27f06b7e11bf8d0ab72e7276c602c::kumasui {
    struct KUMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMASUI>(arg0, 6, b"KumaSui", b"Kuma", b"A cute bear playing in the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732419938410.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUMASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

