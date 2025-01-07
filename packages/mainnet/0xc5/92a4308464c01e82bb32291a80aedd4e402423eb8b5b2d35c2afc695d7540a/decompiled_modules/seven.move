module 0xc592a4308464c01e82bb32291a80aedd4e402423eb8b5b2d35c2afc695d7540a::seven {
    struct SEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVEN>(arg0, 6, b"Seven", b"7sui", b"seven sui is the meme for lover number seven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Immagine_2024_09_12_174359_e97e992fbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

