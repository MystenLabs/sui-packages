module 0xe10b1f7d729ed044d9bf7c4c896abc319dad6db6c82806f4146c13b73e389d3b::croc {
    struct CROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROC>(arg0, 6, b"CROC", b"RETRO CROCODILE", b"Finding one's identity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_5e1a624360.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

