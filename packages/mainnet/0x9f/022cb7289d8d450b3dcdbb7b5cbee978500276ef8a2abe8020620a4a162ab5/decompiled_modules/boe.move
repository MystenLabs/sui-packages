module 0x9f022cb7289d8d450b3dcdbb7b5cbee978500276ef8a2abe8020620a4a162ab5::boe {
    struct BOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOE>(arg0, 9, b"BOE", b"BEYONCE", b"Meme beyonce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d758cdd8-07c8-4670-90a3-a513d65db178.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

