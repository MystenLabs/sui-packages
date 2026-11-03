module 0x560e037f535ff4389a2446608784ceb11da15cb58dca8bb8da36b89c9452e515::v2t487 {
    struct V2T487 has drop {
        dummy_field: bool,
    }

    fun init(arg0: V2T487, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<V2T487>(arg0, 6, b"V2T487", b"V2T487", b"V2T487 LP coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<V2T487>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<V2T487>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

