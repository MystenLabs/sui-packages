module 0x47a6696cb02bf071b929d223dd5e1c143aa876e55ab28efa4b2df91dc9cf6bca::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 6, b"BUNNY", b"Hop Bunny", x"484f502042554e4e59205448452046495253542042554e4e59204f4e205355490a0a4a555354204120564952414c2042554e4e59", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731253875875.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

