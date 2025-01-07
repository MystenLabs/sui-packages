module 0xf877f9dc3df441cae8ca81b1f706421236d2bd1739bdb60c635f4604128feb2f::cash {
    struct CASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASH>(arg0, 9, b"CASH", b"Cashsui (https://x.com/HashOnsui)", b"Hash - A Chad on Sui TG: https://t.me/+8v_MP6KXk0MwMTRh Check out Hash  @hashonsui  - The Chad on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838634819007213568/y2lZIUfv_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CASH>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

