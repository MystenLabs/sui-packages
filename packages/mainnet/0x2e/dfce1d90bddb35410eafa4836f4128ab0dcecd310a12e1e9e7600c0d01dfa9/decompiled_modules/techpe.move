module 0x2edfce1d90bddb35410eafa4836f4128ab0dcecd310a12e1e9e7600c0d01dfa9::techpe {
    struct TECHPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TECHPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TECHPE>(arg0, 6, b"TECHPE", b"TECHPEPE", b"TECHPE is a unique meme-based project on the Sui blockchain, bringing together the humor and creativity of internet culture with blockchain technology. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731585309373.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TECHPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TECHPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

