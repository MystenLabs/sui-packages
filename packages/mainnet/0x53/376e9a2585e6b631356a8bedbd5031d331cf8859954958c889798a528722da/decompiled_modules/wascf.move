module 0x53376e9a2585e6b631356a8bedbd5031d331cf8859954958c889798a528722da::wascf {
    struct WASCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASCF>(arg0, 6, b"WASCF", b"Wrapped AAA smoking catfish", b"Wrapped AAA smoking catfish arrived on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_14_d5e76a6578.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

