module 0x4b2121e73a13d7564378b30b88edeb48fc0fc1de21991bdaf744d1243c2abea9::emma {
    struct EMMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMMA>(arg0, 9, b"EMMA", b"Emma the Dog", b"Emma the Dog of the Universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b84fbf371a5646ac7c1ccd084801ff73blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

