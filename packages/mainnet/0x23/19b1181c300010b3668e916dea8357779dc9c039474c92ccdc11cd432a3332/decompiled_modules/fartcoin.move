module 0x2319b1181c300010b3668e916dea8357779dc9c039474c92ccdc11cd432a3332::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCOIN>(arg0, 6, b"FARTCOIN", b"FARTCOIN on SUI", x"546f6b656e6973696e672066617274732077697468207468652068656c70206f6620626f74732e0a0a46617274636f696e20646576206f727068616e65642069742c2077652061646f70746564202446617274636f696e0a0a4e6f2054472c204e6f20636162616c2c204661727420667265656c792120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ur_Fxr_Fx_400x400_03d29a857a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

