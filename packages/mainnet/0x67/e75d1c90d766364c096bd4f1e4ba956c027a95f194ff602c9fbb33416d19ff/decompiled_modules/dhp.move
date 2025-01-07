module 0x67e75d1c90d766364c096bd4f1e4ba956c027a95f194ff602c9fbb33416d19ff::dhp {
    struct DHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHP>(arg0, 9, b"dHp", b"daHap", b"Perhaps God will do something after that.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/jTTwvhhCZG9xmf2Q9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DHP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

