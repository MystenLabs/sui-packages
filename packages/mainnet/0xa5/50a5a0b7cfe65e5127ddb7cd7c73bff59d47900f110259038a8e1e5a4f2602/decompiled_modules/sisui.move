module 0xa550a5a0b7cfe65e5127ddb7cd7c73bff59d47900f110259038a8e1e5a4f2602::sisui {
    struct SISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISUI>(arg0, 6, b"SISUI", b"Sisu on SUI", b"The spirit of the Finnish people. The viking wreaked havoc with sisu!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_994c661753.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

