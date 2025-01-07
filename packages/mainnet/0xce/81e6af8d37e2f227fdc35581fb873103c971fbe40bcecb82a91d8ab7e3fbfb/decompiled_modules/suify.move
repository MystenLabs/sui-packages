module 0xce81e6af8d37e2f227fdc35581fb873103c971fbe40bcecb82a91d8ab7e3fbfb::suify {
    struct SUIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFY>(arg0, 6, b"SUIFY", b"Suify", x"537569667920697320536f756e64204d6f6e65790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T145104_066_95206e8cb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

