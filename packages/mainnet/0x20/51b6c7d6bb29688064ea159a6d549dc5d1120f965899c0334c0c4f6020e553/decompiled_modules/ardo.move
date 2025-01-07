module 0x2051b6c7d6bb29688064ea159a6d549dc5d1120f965899c0334c0c4f6020e553::ardo {
    struct ARDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARDO>(arg0, 6, b"ARDO", b"ardorlsnf", b"ardorland gud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_14_02_12_03_20162a6492.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

