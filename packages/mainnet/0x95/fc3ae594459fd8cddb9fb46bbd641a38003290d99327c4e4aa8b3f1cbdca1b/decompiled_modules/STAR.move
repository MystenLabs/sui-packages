module 0x95fc3ae594459fd8cddb9fb46bbd641a38003290d99327c4e4aa8b3f1cbdca1b::STAR {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STAR>>(v0);
    }

    public fun mint(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<STAR>, 0x2::coin::CoinMetadata<STAR>) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 9, b"STAR", b"Suiperstar", b"Meet Suiperstar, the meme token that's here to shine! Part cool, part quirky, and totally ready to moon. With the magic of SUI, watch your bags regenerate and grow. No promises, just good vibes. Jump in, hodl tight, and let Suiperstar light up your SUI journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/9tDh8YG/49d05e26-d791-42b2-9e46-272ebc075fa5.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STAR>(&mut v2, 1000000000000000000, @0x38e104edddaf50ea9173e9a0b6bad658d4ce02b06269f6a5ea7635c1d2841ef7, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

