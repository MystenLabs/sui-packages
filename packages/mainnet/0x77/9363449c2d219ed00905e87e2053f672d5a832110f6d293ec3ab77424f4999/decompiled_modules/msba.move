module 0x779363449c2d219ed00905e87e2053f672d5a832110f6d293ec3ab77424f4999::msba {
    struct MSBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSBA>(arg0, 6, b"MSBA", b"MyroDogWifHatWynnTrump6900", b"The first cryptocurrency that sums up all your favourite SUI memes into one. Myro the dog of raj, DogWifHat the famous Dog meme made by Toly (one of big man on crypto) which is smashing millions till now, Anita max Wynn famous recent Drake meme sky rocketing and lastly the legend of memes, Trump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kooo_c250c15874.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

