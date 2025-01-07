module 0xa0646e0105c5a8573ef42300075e4841eed7b39e0b028d5a32885376115f4306::slk420 {
    struct SLK420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLK420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLK420>(arg0, 6, b"SLK420", b"Silk Road 420", b"silk road 420 free Ross", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silk_road_4a68e2eaa0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLK420>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLK420>>(v1);
    }

    // decompiled from Move bytecode v6
}

