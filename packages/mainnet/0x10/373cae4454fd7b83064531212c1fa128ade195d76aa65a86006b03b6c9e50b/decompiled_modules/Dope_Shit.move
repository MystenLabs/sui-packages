module 0x10373cae4454fd7b83064531212c1fa128ade195d76aa65a86006b03b6c9e50b::Dope_Shit {
    struct DOPE_SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE_SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE_SHIT>(arg0, 9, b"DOPE", b"Dope Shit", b"This is the dopest shit ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1849128100464050176/YlFeHfOq_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPE_SHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE_SHIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

