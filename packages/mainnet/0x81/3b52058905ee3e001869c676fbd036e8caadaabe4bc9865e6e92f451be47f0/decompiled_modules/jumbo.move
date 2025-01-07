module 0x813b52058905ee3e001869c676fbd036e8caadaabe4bc9865e6e92f451be47f0::jumbo {
    struct JUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMBO>(arg0, 6, b"JUMBO", b"Jumbo Coco", b"Jumbo is a cheerful, curious monkey whos always ready for fun and mischief. $jumbo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kkxb_JL_Sx_400x400_355366822e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

