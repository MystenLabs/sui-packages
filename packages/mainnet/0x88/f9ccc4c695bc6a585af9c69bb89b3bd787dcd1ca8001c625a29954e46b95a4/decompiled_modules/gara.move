module 0x88f9ccc4c695bc6a585af9c69bb89b3bd787dcd1ca8001c625a29954e46b95a4::gara {
    struct GARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARA>(arg0, 6, b"GARA", b"Gambling Rabbit", b"No socials, just a Gambling Rabbit... Visit our webpage to see the Road Map and start gambling with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736685629368.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

