module 0x1a08ce39ca265bfb240b11e897ba92cb3b528339e099878a67f49b9179b3d69b::hanbao {
    struct HANBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBAO>(arg0, 6, b"HanBao", b"Hanbao the finless porpoise", b"Former Olympian Purveyor of Fine Crustaceans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/100000_6c1235197e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

