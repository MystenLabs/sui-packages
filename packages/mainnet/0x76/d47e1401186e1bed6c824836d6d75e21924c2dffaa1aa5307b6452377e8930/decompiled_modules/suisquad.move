module 0x76d47e1401186e1bed6c824836d6d75e21924c2dffaa1aa5307b6452377e8930::suisquad {
    struct SUISQUAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISQUAD>(arg0, 6, b"SUISQUAD", b"SUI SQUAD", b"$SUISQUAD gonna kill ya until you gone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_202049997_ed32e35f09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISQUAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISQUAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

