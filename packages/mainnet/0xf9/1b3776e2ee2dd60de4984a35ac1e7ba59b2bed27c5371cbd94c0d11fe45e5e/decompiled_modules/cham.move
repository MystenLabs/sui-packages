module 0xf91b3776e2ee2dd60de4984a35ac1e7ba59b2bed27c5371cbd94c0d11fe45e5e::cham {
    struct CHAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAM>(arg0, 6, b"CHAM", b"CRAZY HAMSTER", b"Spinning the meme wheel of fortune. Crazy Hamster is all about wild gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_050226696_0cfee4e306.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

