module 0xbebc635a07542d946949c47f9130c9d6972aa2809322f9e98bfe201ddbd71380::wetc {
    struct WETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETC>(arg0, 6, b"WETC", b"WETCOIN", x"62757920574554434f494e207468697320697320666f72206c6f6e677465726d20756e74696c20626f6e64200a44455820524541445920544f20504159204f4e434520424f4e4445440a424f4f53542057494c4c204143544956415445204f4e434520424f4e444544", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waet_d37b9ef7c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETC>>(v1);
    }

    // decompiled from Move bytecode v6
}

