module 0x357080e50ae066ccc23329be27fdbd9f0bf6e6f1cb6bb4c1d7c1a615156bfcfa::sning {
    struct SNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNING>(arg0, 6, b"SNING", b"SUINNING", b"We're going to SUIN so much, you may even get tired of SUINNING and you'll say please, please, it's too much SUINNING, we cant take it anymore and I'll say no! It isn't, we have to keep SUINNING, we have to SUIN more!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINNING_ICONO_FINAL_GIF_a1c10b53c8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNING>>(v1);
    }

    // decompiled from Move bytecode v6
}

