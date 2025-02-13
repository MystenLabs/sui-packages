module 0xe92c2ed9783d2bd7fda8bb79089af2504a2998ffdd7aa291e9e1beed9eacbe9::bvlis {
    struct BVLIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVLIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVLIS>(arg0, 6, b"BVLIS", b"Beavlis", b"Me beavlis. Me sneaky. Me know you degen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064695_a87654f649.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVLIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BVLIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

