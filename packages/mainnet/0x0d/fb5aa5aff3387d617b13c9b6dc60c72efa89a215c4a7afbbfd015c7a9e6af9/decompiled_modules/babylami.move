module 0xdfb5aa5aff3387d617b13c9b6dc60c72efa89a215c4a7afbbfd015c7a9e6af9::babylami {
    struct BABYLAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYLAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYLAMI>(arg0, 9, b"BABYLAMI", b"Baby Lami", b"Lami The Kitty. To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836099786665021440/efQkTDqc_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYLAMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYLAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYLAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

