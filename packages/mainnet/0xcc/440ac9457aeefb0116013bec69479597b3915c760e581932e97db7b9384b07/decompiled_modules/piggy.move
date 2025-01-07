module 0xcc440ac9457aeefb0116013bec69479597b3915c760e581932e97db7b9384b07::piggy {
    struct PIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGGY>(arg0, 6, b"PIGGY", b"Sui Piggy Coin", b"Sui Piggy Coin aims to bring the world of crypto to everyone with a smile. By combining memes, games, and real-world impact, were building an inclusive and fun space where anyone can explore, earn, and grow no matter their experience level.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/intro_picture_35122314f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

