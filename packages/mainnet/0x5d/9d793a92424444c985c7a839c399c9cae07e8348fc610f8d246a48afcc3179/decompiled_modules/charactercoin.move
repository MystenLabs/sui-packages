module 0x5d9d793a92424444c985c7a839c399c9cae07e8348fc610f8d246a48afcc3179::charactercoin {
    struct CHARACTERCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARACTERCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARACTERCOIN>(arg0, 6, b"CHARACTERCOIN", b"A gift from the barista", b"Today I went to a coffee shop to work. I went outside to talk to a friend. I went back to the coffee shop, picked up my laptop, and went home. At home, I'm cooking and opening my laptop. And here's a gift from the barista. It was very nice. I want to come back again. Or maybe it wasn't from the barista :)))))))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_af145c8116.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARACTERCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARACTERCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

