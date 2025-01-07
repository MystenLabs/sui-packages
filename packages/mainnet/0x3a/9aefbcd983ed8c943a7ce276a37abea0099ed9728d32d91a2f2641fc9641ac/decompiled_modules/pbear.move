module 0x3a9aefbcd983ed8c943a7ce276a37abea0099ed9728d32d91a2f2641fc9641ac::pbear {
    struct PBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBEAR>(arg0, 6, b"Pbear", b"Pbear on Sui", b"Pedo Bear is here to revive the classic internet culture from the golden era of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RC_Uo_SVV_400x400_dd021db28c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

