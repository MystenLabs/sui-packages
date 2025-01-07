module 0x7f9247aa5c8d8324ad4113d6051898ba9ebf23dd82bb7d82a816ce685fbec346::hama {
    struct HAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMA>(arg0, 6, b"HAMA", b"Hamahippo.fun", b"Hamahippo.fun! I was born in Hanoizoo on July 23,2024. I am HAMA. You are HAMA, We are HAMA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731432723894.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

