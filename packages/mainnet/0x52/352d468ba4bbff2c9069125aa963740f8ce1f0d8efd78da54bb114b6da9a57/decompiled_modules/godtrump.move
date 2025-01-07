module 0x52352d468ba4bbff2c9069125aa963740f8ce1f0d8efd78da54bb114b6da9a57::godtrump {
    struct GODTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODTRUMP>(arg0, 6, b"GODTRUMP", b"GOD TRUMP", x"474f445452554d5020544845204e455854204a45535549532057495448205452554d50204d4554412e0a0a4d616b6520416d657269636120477265617420416761696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4092_44c7e71ba6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

