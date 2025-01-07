module 0x827dcb1894eed0d2b09213a8c85af4e07f636e94f3d52ffbb7c63727d61e56a3::nom {
    struct NOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOM>(arg0, 6, b"Nom", b"NomCoin", b"NomNomNomNomNomNomNomNomNom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20241013_001747_13b537fb94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

