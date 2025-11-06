module 0xb123b8fbccbb9716c6488cb56c378624f4ff36787fb7b33309ef690983cd13eb::golf {
    struct GOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLF>(arg0, 6, b"Golf", b"Golfchamber", b"Golfchamber token. It can be used in all Golfchamber clubstores around the world. Golfchamber, golf with style!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1762410416893.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

