module 0xe90dc51455e85d45a4a995c05dabc66062933ac220e76c117a8b1f574ca6bf22::ps6 {
    struct PS6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PS6>(arg0, 6, b"Ps6", b"dead pigeon car battery", b"BAD NEWS XBOX FANS!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_10_182005180_e52588433b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PS6>>(v1);
    }

    // decompiled from Move bytecode v6
}

