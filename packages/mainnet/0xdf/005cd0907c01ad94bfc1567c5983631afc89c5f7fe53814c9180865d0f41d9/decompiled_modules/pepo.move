module 0xdf005cd0907c01ad94bfc1567c5983631afc89c5f7fe53814c9180865d0f41d9::pepo {
    struct PEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPO>(arg0, 6, b"PEPO", b"PEPE POON", b"The name, you ask? It's memorable, perhaps jarring, and fits our main character.| https://suimoonthepoon.fun https://x.com/MoonthePool_Sui https://t.me/PEPEPOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2_2_14aae150b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

