module 0xf9a04da258994794652ae9b17b948c4a8edc90bfbcddbf086c2bb80e7d6d2ba5::wala {
    struct WALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALA>(arg0, 9, b"WALA", b"Wala BABU", b"EXCELLENT MEME FUN COIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4b92deb5edfcd8423a14cd9216988f32blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

