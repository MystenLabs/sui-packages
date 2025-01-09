module 0x59bf9f981ad0723d79bbafa6123b04edc2427f70d454ed3a64888fca748d11da::suity {
    struct SUITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITY>(arg0, 6, b"SUITY", b"Suity", x"53756974792069732061206e65776c7920646576656c6f7065642c2062757420666173742067726f77696e6720636974792c2068657265206f6e2074686520535549206e6574776f726b2c2074686973206973206120706c61636520776865726520796f752063616e2062757920757273656c6620612070726f706572747920666f7220746865206672616374696f6e206f6620746865207072696365206f662049524c2050726f70657274696573210a436f6d65206a6f696e2074686520636f6d6d756e69747920616e64206c657427732067726f772074686973206369747920746f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_046e68ef33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

