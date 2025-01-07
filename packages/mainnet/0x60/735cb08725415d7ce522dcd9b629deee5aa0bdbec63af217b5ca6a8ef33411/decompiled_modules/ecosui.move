module 0x60735cb08725415d7ce522dcd9b629deee5aa0bdbec63af217b5ca6a8ef33411::ecosui {
    struct ECOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOSUI>(arg0, 6, b"ECOSUI", b"E.C.O.S.U.I.S.T.E.M", b"ECOSUISTEM is an innovative NFT marketplace and decentralized application (dApp) built on the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_004014_956_05249c1a7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

