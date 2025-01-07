module 0x8b92b2c41858ac178b4a43382232aeb729929bfe72fb62f62120ca880d492608::foryou {
    struct FORYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORYOU>(arg0, 9, b"FORYOU", b"Apocalypse", b"Safe the World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/004e8969-9b29-4dd4-aecc-992278f17d68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

