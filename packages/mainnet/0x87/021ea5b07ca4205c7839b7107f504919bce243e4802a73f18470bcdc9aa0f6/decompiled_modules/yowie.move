module 0x87021ea5b07ca4205c7839b7107f504919bce243e4802a73f18470bcdc9aa0f6::yowie {
    struct YOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOWIE>(arg0, 9, b"Yowie", b"YOWIE", b"YOWIE token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreihtmd4hqyzmwq2wydjgyx3kxr2svoorlg7sxtidiqznw6g6srn7la.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOWIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOWIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOWIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

