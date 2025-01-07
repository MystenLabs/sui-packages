module 0x89e4b0e81856903dd3af9e522e33792705943bde7a386e328af84586589da34f::evon {
    struct EVON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVON>(arg0, 6, b"EVON", b"EVON CWENG SUI", b"$EVoN, inspired by Evan Cheng - the foundr of SUI Blockcheen - the memecoin for the autisstic and retardzz nerdz that make SUI great!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_70eba4c649.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVON>>(v1);
    }

    // decompiled from Move bytecode v6
}

