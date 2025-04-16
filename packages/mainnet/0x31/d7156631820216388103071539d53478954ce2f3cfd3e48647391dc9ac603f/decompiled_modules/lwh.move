module 0x31d7156631820216388103071539d53478954ce2f3cfd3e48647391dc9ac603f::lwh {
    struct LWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWH>(arg0, 6, b"LWH", b"LOFIWIFHAT", b"Lofi vibes, cool hat, big energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744821537085.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LWH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

