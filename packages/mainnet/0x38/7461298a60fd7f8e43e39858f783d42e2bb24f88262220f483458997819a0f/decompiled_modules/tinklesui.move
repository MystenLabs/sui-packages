module 0x387461298a60fd7f8e43e39858f783d42e2bb24f88262220f483458997819a0f::tinklesui {
    struct TINKLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINKLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINKLESUI>(arg0, 6, b"TINKLESUI", b"TINKLE", x"4d616b696e67206974207261696e206f6e2074686520626c6f636b636861696e0a54494e4b4c4520494e205448452053484f5745522c2054494e4b4c45204f4e2054484520464c4f4f522c0a54494e4b4c45204556455259574845524521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_011939856_ba66b91dfa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINKLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINKLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

