module 0xf9fc2fb3ac2cc09742a2ab6e60790267d2f028dec6a7364c7a0134d440cd0652::wonky {
    struct WONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKY>(arg0, 6, b"WONKY", b"TurboWonky", b"$WONKY is Sui Network's first Wonky meme coin on the market! It's time to Make Meme Sui Great Again, where the player Sui catches the moment of becoming the most naughty and cutest cat in the world.$WONKY says that he wants to go to the moon with his", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986812650.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

