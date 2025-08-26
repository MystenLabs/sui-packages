module 0xc907e27e93629ff8478f580934399ee00c4578466cb9297b2cc1570957398cf1::Non_Aesthetic {
    struct NON_AESTHETIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NON_AESTHETIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NON_AESTHETIC>(arg0, 9, b"AESTHETIC", b"Non Aesthetic", b"non aesthetic things.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/989513875124117504/UNMIb20k_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NON_AESTHETIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NON_AESTHETIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

