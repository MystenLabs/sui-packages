module 0x4f270892ab4cd0606018db4a88c2f4982a51f58c9f6d2e637d12b136b33079de::NOODLE {
    struct NOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOODLE>(arg0, 6, b"Noodle Coin", b"NOODLE", b"A ramen-themed meme coin for the crypto lifestyle, fueling your hunger for gains and delicious DeFi noodles. Slurp up the profits and dive into a bowl of financial freedom!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/s3EjTgZIkjLIARYUijbqln4GFKZXRg5UejavIrw6TMD1vfFVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOODLE>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOODLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

