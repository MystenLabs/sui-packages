module 0x1caad6860d442ab9ed72b18e67e6a851f2581e74997c3b2231bd096bfdf6e98a::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 9, b"SSS", b"sss", b"sss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"sss")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SSS>(&mut v2, 1000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

