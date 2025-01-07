module 0x612405a127bf52240723d1f0f30d09f9de96d0bb9e22654cdc36482598f6d7f1::abuy {
    struct ABUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABUY>(arg0, 6, b"ABUY", b"SuiAbuy", b"ABUY is a tiny, curious creature who loves to hop around and explore new places. Always up for an adventure, ABUY enjoys hanging out in the wild, leaping from one fun spot to another.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001101_cde6319ff1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

