module 0xe1dbf9e6357b8de0731b82a921203d99810bc680712f629e98946292ddfce885::stfg {
    struct STFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STFG>(arg0, 9, b"STFG", b"Streetfights", b"Streetfight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1686a5d8be151d2b6b718bd49ec4255cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

