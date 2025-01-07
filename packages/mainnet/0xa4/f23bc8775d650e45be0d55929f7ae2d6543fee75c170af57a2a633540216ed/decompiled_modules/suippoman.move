module 0xa4f23bc8775d650e45be0d55929f7ae2d6543fee75c170af57a2a633540216ed::suippoman {
    struct SUIPPOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPPOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPPOMAN>(arg0, 6, b"SUIPPOMAN", b"Suppomans Toilet", b"Behold Suppomans Toilet on the Sui Blockchain Network.  The Japanese word Sui () means \"water\". It is one of the five elements in the Japanese system of elements and represents the fluid, flowing, and formless things in the world.  Suppomans Toilet has everything to do with fluid, flowing, and formless.  Suppomans Toilet is one of a kind to collect and hold, only on the Sui Blockchain Network.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045692_89ea7f5109.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPPOMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPPOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

