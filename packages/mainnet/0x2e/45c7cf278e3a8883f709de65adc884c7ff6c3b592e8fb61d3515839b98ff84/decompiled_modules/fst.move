module 0x2e45c7cf278e3a8883f709de65adc884c7ff6c3b592e8fb61d3515839b98ff84::fst {
    struct FST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FST>(arg0, 6, b"FST", b"Fusion Skull Token", b"Fusion Skull Token (FST) is a pure meme coin that draws inspiration from a playful and quirky fusion of skeleton and cartoon elements. The character's colorful, humorous vibe makes it a perfect symbol for a fun, lighthearted cryptocurrency. With a total supply of 10 billion tokens, FST is completely community-driven, embracing the spirit of meme culture with no underlying utility beyond being entertaining and engaging. The project adopts a no-reserve, fair-launch model, ensuring 100% of tokens are in circulation from day one to foster community ownership and participation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/af0_ff9d301f18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FST>>(v1);
    }

    // decompiled from Move bytecode v6
}

