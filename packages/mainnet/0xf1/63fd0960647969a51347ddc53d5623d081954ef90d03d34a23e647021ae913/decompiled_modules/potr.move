module 0xf163fd0960647969a51347ddc53d5623d081954ef90d03d34a23e647021ae913::potr {
    struct POTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTR>(arg0, 6, b"POTR", b"PLAYFUL OTTER", b"Sliding into the meme stream with mischief and charm. Playful Otter is a splash of gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_034128121_f38a1a1c7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

