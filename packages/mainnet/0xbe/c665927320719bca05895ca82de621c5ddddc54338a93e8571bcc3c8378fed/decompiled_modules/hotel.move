module 0xbec665927320719bca05895ca82de621c5ddddc54338a93e8571bcc3c8378fed::hotel {
    struct HOTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTEL>(arg0, 9, b"Hotel", b"Habbo", b"Origins.Habbo.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/15b8c49a9ef8fe41df26367870fabfaeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOTEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

