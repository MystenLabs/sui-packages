module 0x5c49fa69b7a333a5197da23bc70d9e6a8faf931b3fed6e3d4f887f64face1431::bphil {
    struct BPHIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPHIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPHIL>(arg0, 9, b"BPHIL", b"Baby Phil", b"Baby Phil Sui Baby Dragon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1828841764326719488/1N8y20sd_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BPHIL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPHIL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPHIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

