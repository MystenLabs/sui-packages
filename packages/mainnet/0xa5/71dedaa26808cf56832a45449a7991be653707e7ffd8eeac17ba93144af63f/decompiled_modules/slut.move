module 0xa571dedaa26808cf56832a45449a7991be653707e7ffd8eeac17ba93144af63f::slut {
    struct SLUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLUT>(arg0, 6, b"SLUT", b"Sea Slut", b"SeaSlut is the sluttiest siren of the Sui blockchain, a mermaid whose seductive charm influences crypto trends and community vibes. With each interaction, she flirts with market forces and other coins, creating memes that are as provocative as they are playful.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_12_20_084948_d242413fd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLUT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

