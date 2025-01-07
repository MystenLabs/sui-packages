module 0xae4ee9c33b110de5beec978d068420f9b8dbffa63f55481b120bb2d4503ee232::pepinu {
    struct PEPINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPINU>(arg0, 6, b"PEPINU", b"Pepinu", b"Pepinu is a memecoin on Sui with 0/0 tax on buy and sells. sits alongside its memecoin mates Pepe and Shiba Inu, sparking giggles in the financial playground and makes a lot of millionaires without actually bringing much to the table in terms of prac", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731341265330.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

