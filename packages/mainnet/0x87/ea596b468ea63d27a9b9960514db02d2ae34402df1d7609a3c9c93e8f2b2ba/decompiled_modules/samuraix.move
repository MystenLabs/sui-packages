module 0x87ea596b468ea63d27a9b9960514db02d2ae34402df1d7609a3c9c93e8f2b2ba::samuraix {
    struct SAMURAIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMURAIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMURAIX>(arg0, 6, b"SamuraiX", b"Samurai X Sui", b"Rurouni Kenshin or Samurai X is an anime based on the popular manga series by Nobuhiro Watsuki. Kenshin Himura is the main character in this series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749492654298.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMURAIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMURAIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

