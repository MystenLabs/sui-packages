module 0xdbbdfaedbd81ade614d205c62b6570182d786dd1c628694b71b51fabde0c894f::safe {
    struct SAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFE>(arg0, 6, b"SAFE", b"Safe CatDog", b"Take care of your little friends. Save them ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/safe_catddog_9c59b679e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

