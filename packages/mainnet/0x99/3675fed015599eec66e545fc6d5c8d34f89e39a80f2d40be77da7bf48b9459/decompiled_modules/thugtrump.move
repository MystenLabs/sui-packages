module 0x993675fed015599eec66e545fc6d5c8d34f89e39a80f2d40be77da7bf48b9459::thugtrump {
    struct THUGTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUGTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THUGTRUMP>(arg0, 6, b"ThugTrump", b"Thrump", x"5374726169676874206f75747461204e5943210a4a6f696e207468652067616e6720616e64206c6574732062616e6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_10_97d5c9a8e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THUGTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THUGTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

