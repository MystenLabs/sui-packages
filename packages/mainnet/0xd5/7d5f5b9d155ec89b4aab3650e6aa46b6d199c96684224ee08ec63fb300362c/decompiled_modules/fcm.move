module 0xd57d5f5b9d155ec89b4aab3650e6aa46b6d199c96684224ee08ec63fb300362c::fcm {
    struct FCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://pbs.twimg.com/profile_images/1976255580160303105/11itoqL1_400x400.jpg";
        let v1 = if (0x1::vector::is_empty<u8>(&v0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"{{ICON_URL}}"))
        };
        let (v2, v3) = 0x2::coin::create_currency<FCM>(arg0, 9, b"FCM", b"Football Capital Markets", b"On a mission to bring every football fan on-chain. Trade player tokens. Earn from performance.", v1, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCM>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCM>>(v3);
    }

    // decompiled from Move bytecode v7
}

