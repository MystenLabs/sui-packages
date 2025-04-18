module 0x6c63c83a77952c6ba8add48eda84f85dbe61669e049b3d84440c1c6646b1dbfe::cypt {
    struct CYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYPT>(arg0, 9, b"CYPT", b"CRYPTOTOP", b"Memecoin for all content creators, guarantee your CYPT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d75e17071fec3a933a22dd2962a5b9c9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

