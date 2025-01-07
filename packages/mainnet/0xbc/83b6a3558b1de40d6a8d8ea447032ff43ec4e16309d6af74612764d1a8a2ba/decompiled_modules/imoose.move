module 0xbc83b6a3558b1de40d6a8d8ea447032ff43ec4e16309d6af74612764d1a8a2ba::imoose {
    struct IMOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMOOSE>(arg0, 6, b"IMOOSE", b"iMOOSE", b"iMOOSE means  i branding of the \"Moonshot Opportunity Of SUI Ecosystem\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moonshot_moose_601_783a650155.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

