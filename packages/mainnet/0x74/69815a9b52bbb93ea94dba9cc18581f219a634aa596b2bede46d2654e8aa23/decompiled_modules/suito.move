module 0x7469815a9b52bbb93ea94dba9cc18581f219a634aa596b2bede46d2654e8aa23::suito {
    struct SUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITO>(arg0, 6, b"SUITO", b"SUITO THE SHARK", x"4f4646494349414c2024535549544f20544f4b454e204f4e205355492e0a0a54454c454752414d204f50454e0a4f5247494e414c20415254", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitorocket_7686a1e0cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

