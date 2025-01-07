module 0x7ce8c5107943b3ce0b46ec04f791b1f7c118ad41ea96fa59dcca7a1639626e4e::babyeven {
    struct BABYEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYEVEN>(arg0, 9, b"BABYEVEN", b"Baby Even", b"cA-fauNdeR cEo bABY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1837070337797951488/ZPTUY1ra_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYEVEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYEVEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

