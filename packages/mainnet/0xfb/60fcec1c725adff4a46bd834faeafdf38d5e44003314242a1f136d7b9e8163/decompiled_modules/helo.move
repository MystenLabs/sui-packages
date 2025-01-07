module 0xfb60fcec1c725adff4a46bd834faeafdf38d5e44003314242a1f136d7b9e8163::helo {
    struct HELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELO>(arg0, 6, b"HELO", b"Helo Fish", b"Helo Fish, also known as Staring Fish has come to dominate Sui's meme world! Plunge deep into the sea of memes and spread the word that $HELO is here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/id_please_ik_its_a_meme_im_not_joking_v0_je59me881gna1_ba3c3ece3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

