module 0x3672969320c65572338a6096d22800bab7500731056eca8e3d31fe1e2c2f2f02::ascii_art {
    struct ASCII_ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASCII_ART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASCII_ART>(arg0, 6, b"ASCII_ART", b"Grand Father of NFT", b"Who have got computers from 80's. They understand what it mean. And Grandpa works for you again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747906606846.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASCII_ART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASCII_ART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

