module 0x42a331ed661ef893fa5c81ad52769442e17b658bf2be70a73817fab3c0716330::regi {
    struct REGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGI>(arg0, 6, b"REGI", b"Resistance Girl", b"Inspired by Pavel Durovs creation, Resistance Dog, Resistance Girl is a digital emblem against censorship, echoing the ethos of Resistance Dog ($REDO) and Telegrams mission for free expression.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9550_45b66f76a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

