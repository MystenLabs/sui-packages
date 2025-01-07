module 0xe13f1736aa1e40d01eb4d63b24c02b18a517c26d44f7e6c6ad6cca3a11434f34::myc {
    struct MYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYC>(arg0, 6, b"MYC", b"My Yellow Chick", b"MY YELLOW CHICK (MYC) is a next-gen token blending meme culture with gaming utility. Focused on indie gaming, MYC monetizes games, fosters communities, and rewards users. Join MYC for an exciting future in cryptocurrency and gaming innovation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732631700740.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

