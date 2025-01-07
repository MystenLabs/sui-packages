module 0xe0ba33f6562d75ca8c4a00e778c60ff90f2984156d044a674a6503cdc8af017b::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 5, b"SUINAMI", b"SUINAMI", b"The End is Near!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media-assets.wired.it/photos/63e0e86b857b9ef6bd8fc8f0/3:2/w_4200,h_2800,c_limit/todd-turner-Af9cNES03LU-unsplash.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUINAMI>(&mut v2, 5000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

