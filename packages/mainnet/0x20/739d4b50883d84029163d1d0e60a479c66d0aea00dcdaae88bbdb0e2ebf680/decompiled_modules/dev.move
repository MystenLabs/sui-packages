module 0x20739d4b50883d84029163d1d0e60a479c66d0aea00dcdaae88bbdb0e2ebf680::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"DEV", b"Dev Retardio", b"Too retarded to sell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/devvv_79e6a25ff7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

