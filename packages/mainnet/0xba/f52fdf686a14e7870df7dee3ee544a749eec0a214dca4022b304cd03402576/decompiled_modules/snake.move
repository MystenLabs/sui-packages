module 0xbaf52fdf686a14e7870df7dee3ee544a749eec0a214dca4022b304cd03402576::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"Two-headed snake", b"2025 is the Year of the Snake, and as the zodiac sign of the natal year, people born in the Year of the Snake are often considered to be the year that needs to be treated with the most caution, especially during the \"Double Spring Year\". The Year of the Snake is also the \"natal year\" for snake people, and many people will wear red clothes and socks in order to pray for peace of mind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_C_50b3fc6877.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

