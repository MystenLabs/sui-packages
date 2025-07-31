module 0x730e83bdf19ddffad730fb17812aff8c47439ae42defad6cf7e5a5233d5264bb::Defi {
    struct DEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFI>(arg0, 9, b"DB", b"Defi", b"the dopest defi in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1949987401159282688/NAwCg4Ce_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

