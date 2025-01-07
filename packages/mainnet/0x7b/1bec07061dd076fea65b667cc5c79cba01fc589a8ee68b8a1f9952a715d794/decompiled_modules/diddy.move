module 0x7b1bec07061dd076fea65b667cc5c79cba01fc589a8ee68b8a1f9952a715d794::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"PDIDDY", x"49276d20446964647920616e6420796120617265206d7920736f6e2e2043616c6c206d65204461646479206d66657273210a4c495645204f4e20535549204e4554574f524b212121210a4c4647212121210a42555959595959204e4f5757575721212121212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/diddy_cee8a61b4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

