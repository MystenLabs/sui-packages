module 0x252d9544441b270cf2f52e9eff91952342f1bd650bf803d420fa07b3b673eb41::sinu {
    struct SINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINU>(arg0, 9, b"Sinu", b"Saya inu", b"Lfg new meme coin with no use case ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a6036e42487c064b4213f22f393cd7abblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

