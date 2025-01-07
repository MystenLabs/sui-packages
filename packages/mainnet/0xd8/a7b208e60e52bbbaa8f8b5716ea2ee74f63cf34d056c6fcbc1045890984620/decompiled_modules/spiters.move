module 0xd8a7b208e60e52bbbaa8f8b5716ea2ee74f63cf34d056c6fcbc1045890984620::spiters {
    struct SPITERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPITERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPITERS>(arg0, 6, b"SPITERS", b"SpitermanOnSui", b"Hola, Me llamo Gonzalo Fernandez, soy de Argentina cree esta meme para que nos riamos un poco, voy a subir memes en mi perfil de instagram y twitter. Siganme no los voy a defraudar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spiterman_0941fb3f97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPITERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPITERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

