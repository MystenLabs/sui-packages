module 0x94ea8ea2024814751c176813f886748d1a527fcd12f000c22a4674cf38c4c4ab::clr {
    struct CLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLR>(arg0, 9, b"CLR", b"CLARA", b"Dedicating this meme to someone special to me and I will do everything possible for it to succeed for the sake of this person so let's make this fly community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dda39eb-80ff-41c4-b3f4-b71185015524.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

