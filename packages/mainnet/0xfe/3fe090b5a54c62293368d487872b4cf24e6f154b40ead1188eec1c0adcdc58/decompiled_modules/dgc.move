module 0xfe3fe090b5a54c62293368d487872b4cf24e6f154b40ead1188eec1c0adcdc58::dgc {
    struct DGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGC>(arg0, 6, b"DGC", b"DoggoCheese", b"DoggoCheese (DGC) is a meme token that combines the fun of dog memes with a cheesy twist, creating a viral and humorous crypto experience. With its beloved dog meme imagery and quirky charm, DGC is designed to be funny, shareable, and a lighthearted investment option. Whether you love dog memes or crypto, DoggoCheese offers a fun way to invest and be part of internet culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_04_09_31_55_A_more_realistic_token_logo_featuring_a_cute_smiling_dog_holding_a_wedge_of_cheese_The_dog_should_have_detailed_fur_and_realistic_features_with_sof_77a5f8b11c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

