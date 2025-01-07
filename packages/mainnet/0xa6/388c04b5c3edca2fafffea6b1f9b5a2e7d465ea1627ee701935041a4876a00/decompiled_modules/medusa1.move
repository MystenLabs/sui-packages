module 0xa6388c04b5c3edca2fafffea6b1f9b5a2e7d465ea1627ee701935041a4876a00::medusa1 {
    struct MEDUSA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSA1>(arg0, 6, b"Medusa1", b"Medusa", b"I'm like echo of your feelings first coin ever deployed by AI LUNA on PF ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000134376_8108577b3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSA1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSA1>>(v1);
    }

    // decompiled from Move bytecode v6
}

