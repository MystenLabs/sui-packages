module 0xfed4ccb1ff03d1849abaa4fa29d941225b658225397562260474500ba7b4863b::waterdog {
    struct WATERDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERDOG>(arg0, 6, b"Waterdog", b"Portuguese Water Dog", b"Portuguese Water Dog could be found throughout the entire Portuguese coast. The breed was located mainly in the Algarve region which is now considered as its original birthplace. Join us to support this exceptional Dog Breed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1774203315820.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATERDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

