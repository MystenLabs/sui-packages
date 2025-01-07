module 0xa387f47f1890eabdbdae57cae1514ea812549b06905cd4c8e53b0d915705191e::ANGEL {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGEL>(arg0, 9, b"ANGEL", b"Descending Angel", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/081/021/315/large/maarten-verhoeven-001-done.jpg?1729162380")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ANGEL>>(0x2::coin::mint<ANGEL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ANGEL>>(v2);
    }

    // decompiled from Move bytecode v6
}

