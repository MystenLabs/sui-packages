module 0xcfd4be3aefc1798007545da41e156449a39fce82ca2bcfc1ae552a430e472903::wly {
    struct WLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLY>(arg0, 9, b"WLY", b"WAL-LUFFY", b"futur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1b35626034e75fe873421fd56d581af2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

