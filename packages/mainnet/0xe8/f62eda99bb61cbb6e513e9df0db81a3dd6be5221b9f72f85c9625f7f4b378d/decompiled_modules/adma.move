module 0xe8f62eda99bb61cbb6e513e9df0db81a3dd6be5221b9f72f85c9625f7f4b378d::adma {
    struct ADMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADMA>(arg0, 6, b"Adma", b"Adam=satoshi", b"$adam is more likely to be the real satoshi than len as people predict on polymarket!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/725_231b0eb8b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

