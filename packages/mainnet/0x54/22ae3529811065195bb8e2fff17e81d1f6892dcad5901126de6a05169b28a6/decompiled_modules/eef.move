module 0x5422ae3529811065195bb8e2fff17e81d1f6892dcad5901126de6a05169b28a6::eef {
    struct EEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEF>(arg0, 6, b"EEF", b"eef SUI", b"goal: da #1 community on Sui. $eef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_904501ada4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

