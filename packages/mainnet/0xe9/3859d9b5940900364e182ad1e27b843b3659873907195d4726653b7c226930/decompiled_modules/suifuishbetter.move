module 0xe93859d9b5940900364e182ad1e27b843b3659873907195d4726653b7c226930::suifuishbetter {
    struct SUIFUISHBETTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUISHBETTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUISHBETTER>(arg0, 6, b"SUIFUISHbetter", b"SUI FUISH", x"4a7573742061206669736820696e2074686520537569204f6365616e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_D_D_9b463b629b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUISHBETTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUISHBETTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

