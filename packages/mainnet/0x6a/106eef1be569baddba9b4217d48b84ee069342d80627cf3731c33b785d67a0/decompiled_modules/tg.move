module 0x6a106eef1be569baddba9b4217d48b84ee069342d80627cf3731c33b785d67a0::tg {
    struct TG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TG>(arg0, 6, b"TG", b"Telegram", x"54686520636f696e207468617420646f6573206162736f6c7574656c79206e6f7468696e67e280946a757374206c696b6520796f75722067726f75702063686174732e204e6f207574696c6974792c206e6f20726f61646d61702c206a75737420707572652076696265732e2024544720657869737473206265636175736520736f6d656f6e65207361696420e2809c77686174206966207765206d616465206120636f696ee280a620616e64206469646ee2809974206576656e207472793fe2809d20536f207765206469642e2057656c636f6d6520746f207065616b2063727970746f2069726f6e792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747958966881.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

