module 0xcd95bce9fe8e8871646439230926398698d674ac53b6586da3780f38ae7b609d::chirpy {
    struct CHIRPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRPY>(arg0, 6, b"CHIRPY", b"SUI CHIRPY", b"Introducing CHIRPY $CHIRPY, the new ERC meme token ready to ride the wave of the upcoming bull run! While Matt Furie's Pepe is iconic, many fans might not know about his brother, Jason Furie, who also played a crucial role in Pepe's success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731433674936.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIRPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIRPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

