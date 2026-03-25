module 0x5fb8d12d6c0e6662541bf9f2120df3ad58decfd230985211fa4868cf3396cf77::shmzu {
    struct SHMZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHMZU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774397504153-79f10402fdcbbd12bd8f22b63412a8c8.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774397504153-79f10402fdcbbd12bd8f22b63412a8c8.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<SHMZU>(arg0, 9, b"SHMZU", b"Kiyou shimizu", b"SHMZU is dedicated to all fans of Kiyou Shimizu around the world", v1, arg1);
        let v4 = v2;
        if (800000000000000000 > 0) {
            0x2::coin::mint_and_transfer<SHMZU>(&mut v4, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHMZU>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHMZU>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

