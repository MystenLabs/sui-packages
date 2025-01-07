module 0xe546da3fdc81ec26195c63716fd4e024bdc6c6d5c61740157f51a446963e8a13::boi {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 6, b"BOI", b"Boi", x"426f692077697468206869732064726f6f7079206579657320616e6420717569726b79206772696e2c20686520656d626f646965732074686520756e707265646963746162696c697479206f66207468652063727970746f20776f726c64e28094736f6d6574696d657320612062697420636f6e66757365642c2062757420616c7761797320726561647920666f7220746865206e65787420616476656e7475726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843685564760907776/uJoGFof7.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BOI>>(0x2::coin::mint<BOI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

