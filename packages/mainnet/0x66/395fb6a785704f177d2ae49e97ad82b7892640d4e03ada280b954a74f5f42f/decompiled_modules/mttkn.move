module 0x66395fb6a785704f177d2ae49e97ad82b7892640d4e03ada280b954a74f5f42f::mttkn {
    struct MTTKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTTKN>(arg0, 6, b"MTTKN", b"A Dummy Token", b"A Dummy Testing Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ui-avatars.com/api/?name=MTTKN&length=20&size=512&font-size=0.1&bold=true&background=000000")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MTTKN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTTKN>>(v2, @0x8532a0efda8f92811c1cc31044dbd9b25e85283ab56ba23a7d622141bdc1d2f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTTKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

