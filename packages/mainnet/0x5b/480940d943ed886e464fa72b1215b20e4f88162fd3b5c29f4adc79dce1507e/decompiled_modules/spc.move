module 0x5b480940d943ed886e464fa72b1215b20e4f88162fd3b5c29f4adc79dce1507e::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 11, b"SPC", b"SimpCat", b"simp cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.redd.it/long-haired-siamese-v0-1dkn8zf5wekc1.jpg?width=1440&format=pjpg&auto=webp&s=d6fece46f2f2b8e8bfb09f914b57b97246608414")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

