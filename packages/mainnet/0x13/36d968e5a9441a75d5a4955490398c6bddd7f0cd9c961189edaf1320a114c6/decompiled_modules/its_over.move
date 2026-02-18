module 0x1336d968e5a9441a75d5a4955490398c6bddd7f0cd9c961189edaf1320a114c6::its_over {
    struct ITS_OVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITS_OVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITS_OVER>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"ITS_OVER", b"its over", b"withdraw your money. sui was a mistake.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.tenor.com/ctO2QkhV05kAAAAe/crying-crying-meme.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ITS_OVER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITS_OVER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

