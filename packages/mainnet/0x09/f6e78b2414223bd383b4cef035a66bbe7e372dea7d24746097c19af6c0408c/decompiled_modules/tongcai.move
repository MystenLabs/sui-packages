module 0x9f6e78b2414223bd383b4cef035a66bbe7e372dea7d24746097c19af6c0408c::tongcai {
    struct TONGCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONGCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONGCAI>(arg0, 6, b"TONGCAI", b"Tongcaitrump", b"$TONGCAI Make American Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037045_95c6d54663.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONGCAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONGCAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

