module 0xa20221924d517b01875fc50b3f17b62b5c09e95f70c550b1cd3db17310ec7677::suipepedeng {
    struct SUIPEPEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPEDENG>(arg0, 6, b"SuiPepeDeng", b"Sui Pepe Deng", b"If Pepe and Moo Deng had a baby, itd be the legendary Sui Pepe Deng.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_1_8e8791012d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

