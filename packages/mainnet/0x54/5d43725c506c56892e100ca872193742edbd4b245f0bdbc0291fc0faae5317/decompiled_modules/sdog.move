module 0x545d43725c506c56892e100ca872193742edbd4b245f0bdbc0291fc0faae5317::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SuiDog", b"The best friend of SCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/cute-3d-dog-image_776894-123838.jpg?uid=R159192140&ga=GA1.1.1940679477.1723740906&semt=ais_hybrid")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDOG>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

