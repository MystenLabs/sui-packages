module 0xa3dc30132c43776db236126c01cd81ff54761433aa437876dd26e40563bb301d::poold {
    struct POOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOLD>(arg0, 6, b"POOLD", b"POOLDSUI", x"496e7665737420696e20476c616d6f75722c20496e7665737420696e20506f6f646c616e612e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/center_dog_3dec2641d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

