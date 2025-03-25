module 0x6ee832cd6ac76871dd2566997239aade96072d8e37e72f01099ffba875cfb5e7::ci {
    struct CI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CI>(arg0, 9, b"CI", b"Cina", b"This crypto currency refer to Ibn Cina,Among the great sages of Islamic medicine, Ibn Sina is the best known in the West. Considered as the successor to Galen, his great medical treatise, the Canon was the standard textbook on medicine in the Arab world and Europe in the 17th century. He was a philosopher, physician, psychiatrist and poet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CI>>(v1);
    }

    // decompiled from Move bytecode v6
}

