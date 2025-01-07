module 0x6ff49778dfe3319fddb5f7accfcc73472e2f0529eb837e21b294017af618e462::gust {
    struct GUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUST>(arg0, 9, b"GUST", b"got up and see this", b"when i get up i see this i am speechless!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2b1d622d4ce808f8471428639893e205blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

