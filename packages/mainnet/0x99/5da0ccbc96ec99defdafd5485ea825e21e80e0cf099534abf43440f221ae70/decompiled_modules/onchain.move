module 0x995da0ccbc96ec99defdafd5485ea825e21e80e0cf099534abf43440f221ae70::onchain {
    struct ONCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONCHAIN>(arg0, 6, b"ONCHAIN", b"Baby Onchain", b"Five years ago, we set an ambitious goal to become carbon neutral across every part of our business by 2030. Today, were announcing weve reduced our global emissions by more than 60%and were using more recycled materials and renewable energy than ever before. Baby Onchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059265_469aa2ae7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

