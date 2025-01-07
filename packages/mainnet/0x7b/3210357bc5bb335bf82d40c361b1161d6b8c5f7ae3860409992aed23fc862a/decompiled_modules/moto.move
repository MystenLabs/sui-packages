module 0x7b3210357bc5bb335bf82d40c361b1161d6b8c5f7ae3860409992aed23fc862a::moto {
    struct MOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTO>(arg0, 6, b"MOTO", b"Moto Moto", b"Big, chunky, and impossible to ignore. MOTO MOTO is crashing onto the Sui network with style. Don't miss out, because MOTO MOTO's got his eyes on you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moto_1_c51cb1511b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

