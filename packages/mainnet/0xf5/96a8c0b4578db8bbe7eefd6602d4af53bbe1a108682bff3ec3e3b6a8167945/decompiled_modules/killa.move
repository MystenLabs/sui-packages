module 0xf596a8c0b4578db8bbe7eefd6602d4af53bbe1a108682bff3ec3e3b6a8167945::killa {
    struct KILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLA>(arg0, 6, b"KILLA", b"Killa Club", b"Hunter's,unite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2186_e79f3aaf12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

