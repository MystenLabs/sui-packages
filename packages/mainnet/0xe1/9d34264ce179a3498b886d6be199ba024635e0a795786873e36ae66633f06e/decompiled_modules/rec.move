module 0xe19d34264ce179a3498b886d6be199ba024635e0a795786873e36ae66633f06e::rec {
    struct REC has drop {
        dummy_field: bool,
    }

    fun init(arg0: REC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REC>(arg0, 6, b"REC", b"REC Protocol", b"OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3397_8bf1dad2d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REC>>(v1);
    }

    // decompiled from Move bytecode v6
}

