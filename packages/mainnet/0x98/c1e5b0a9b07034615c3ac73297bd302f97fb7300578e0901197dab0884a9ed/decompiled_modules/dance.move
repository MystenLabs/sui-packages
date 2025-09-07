module 0x98c1e5b0a9b07034615c3ac73297bd302f97fb7300578e0901197dab0884a9ed::dance {
    struct DANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANCE>(arg0, 9, b"DANCE", b"Dancing Guy", b"Dance to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/originals/59/87/eb/5987eb0ef1dc3b3ba0492a82808d8177.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DANCE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANCE>>(v2, @0x1fe081bbe65ea302a5ac3a8dcfb483a87d6936829d8fac55dab2c5e8b4eed990);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

