module 0xf0f7edd248cd83097546e131d94c06cac0ce072674aff5a35745639368e63eae::creepycroc {
    struct CREEPYCROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREEPYCROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREEPYCROC>(arg0, 6, b"CREEPYCROC", b"Creepy Croc SUI", b"**Creepy Croc** slinks through the shadows, glowing red eyes and sharp fangs ready to strike! This mischievous baby croc haunts the night, creeping silently for the perfect Halloween scare!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Creepy_Croc_fdd876aa17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREEPYCROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREEPYCROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

