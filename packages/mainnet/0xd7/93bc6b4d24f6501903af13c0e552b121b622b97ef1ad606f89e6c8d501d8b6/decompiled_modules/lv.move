module 0xd793bc6b4d24f6501903af13c0e552b121b622b97ef1ad606f89e6c8d501d8b6::lv {
    struct LV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LV>(arg0, 9, b"LV", b"LV", b"luyisvden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-65N5F4cdyg2apksdKdchR5?se=2025-02-11T06%3A50%3A16Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D604800%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D0329cbf8-719b-47c1-850e-fe8db6d9bd97.webp&sig=tvdBcMlBk%2BDJ2U5fI9Jzm/gJAgB3vSdUcz0VlmRlGC8%3D")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LV>>(v1);
        0x2::coin::mint_and_transfer<LV>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

