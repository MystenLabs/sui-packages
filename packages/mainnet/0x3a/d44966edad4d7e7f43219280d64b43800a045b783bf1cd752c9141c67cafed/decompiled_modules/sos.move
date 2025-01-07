module 0x3ad44966edad4d7e7f43219280d64b43800a045b783bf1cd752c9141c67cafed::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"Shaiky Of Sui", b"Shaiky in Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1034_52beec4322.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

