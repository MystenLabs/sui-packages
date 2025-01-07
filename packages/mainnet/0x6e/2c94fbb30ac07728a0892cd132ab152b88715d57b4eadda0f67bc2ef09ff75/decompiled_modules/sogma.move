module 0x6e2c94fbb30ac07728a0892cd132ab152b88715d57b4eadda0f67bc2ef09ff75::sogma {
    struct SOGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGMA>(arg0, 6, b"SOGMA", b"I AM SOGMA", b"SOGMA is meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_15_02_56_814e15add1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

