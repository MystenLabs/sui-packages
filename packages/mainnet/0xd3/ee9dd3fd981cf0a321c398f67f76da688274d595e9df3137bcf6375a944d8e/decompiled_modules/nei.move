module 0xd3ee9dd3fd981cf0a321c398f67f76da688274d595e9df3137bcf6375a944d8e::nei {
    struct NEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEI>(arg0, 6, b"Nei", b"Neiro sui", b"neiro on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_220958_06e8e45d6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

