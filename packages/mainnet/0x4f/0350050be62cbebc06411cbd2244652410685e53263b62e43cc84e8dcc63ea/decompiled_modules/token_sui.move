module 0x4f0350050be62cbebc06411cbd2244652410685e53263b62e43cc84e8dcc63ea::token_sui {
    struct TOKEN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_SUI>(arg0, 9, b"NoCEX", b"No CEX No SEX", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1744355559539621888/4JBkKWI4_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_SUI>>(0x2::coin::mint<TOKEN_SUI>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

