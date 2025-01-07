module 0xd339cfda60d2bc8facc1cea99ebaaa67e319286cb9b9562aab9557be53d2a0c5::suinake {
    struct SUINAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAKE>(arg0, 6, b"SUINAKE", b"SNAKE OF SUI FORESTS", b"$SUINAKE is a sleek and agile token on Sui, inspired by the stealth and precision of a snake in the Sui forests. Just like a snake moves swiftly through its terrain, $SUINAKE navigates the markets with speed and cunning. Embrace the power of the snake of Sui forests and strike at the right moment!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINAKEE_b77abced9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

