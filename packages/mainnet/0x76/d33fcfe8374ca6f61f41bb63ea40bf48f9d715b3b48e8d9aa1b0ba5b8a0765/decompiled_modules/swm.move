module 0x76d33fcfe8374ca6f61f41bb63ea40bf48f9d715b3b48e8d9aa1b0ba5b8a0765::swm {
    struct SWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWM>(arg0, 6, b"SWM", b"SUIWOMEN", b"Suiwoman is a meme token on the Sui, combining the fun of superhero vibes with the power of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kandinsky_download_1728326990066_cad7767c72.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

