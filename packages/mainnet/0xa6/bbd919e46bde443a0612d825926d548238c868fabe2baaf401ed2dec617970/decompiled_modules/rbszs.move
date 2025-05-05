module 0xa6bbd919e46bde443a0612d825926d548238c868fabe2baaf401ed2dec617970::rbszs {
    struct RBSZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBSZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBSZS>(arg0, 9, b"Rbszs", b"rha1b", b"rha1b than beautifil Bob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/51561a48cbb0638c7e51e41134cd3df4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBSZS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBSZS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

