module 0x3471b3995a0af328a818fb56b6d32d384142603e8a940de34f420278f622c870::feslegen {
    struct FESLEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FESLEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FESLEGEN>(arg0, 9, b"Feslegen", x"4665736c6567656e20f09fa6ad2f616363", x"536176696f72206f66207375692065636f2073797374656d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cea40076784553863d72bec61d4219f8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FESLEGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FESLEGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

