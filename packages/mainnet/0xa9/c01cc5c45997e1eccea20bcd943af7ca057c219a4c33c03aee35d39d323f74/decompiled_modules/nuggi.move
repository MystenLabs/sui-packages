module 0xa9c01cc5c45997e1eccea20bcd943af7ca057c219a4c33c03aee35d39d323f74::nuggi {
    struct NUGGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUGGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUGGI>(arg0, 6, b"NUGGI", b"ChimkinNuggi", b"ChimkinNuggi is the cutest, most adorable nuggi there is he just wants to build a nest for winter, let's help him achieving his goal, join the community, and don't forget to bring some building materials", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_1_2997866877.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUGGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUGGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

