module 0x11adaec57eb98f9f365ada5588c39695fb62f2bf6d4da12969f15e42fc92b753::sbrett {
    struct SBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRETT>(arg0, 6, b"SBRETT", b"Suibrett", b"The legend of SuiBrett: the guardian of memecoins on the Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suibrett_978a19658e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

