module 0x2ca15595ac70d03f0f27a59d85faf9f03aa83a0866b183ca62503edd13786c8::blum {
    struct BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUM>(arg0, 9, b"BLUM", b"BLUM", b"Something majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=dce39ddfd7389d88bfd770e89a0941b8_l-5233438-images-thumbs&n=13")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

