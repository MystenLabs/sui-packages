module 0xdfbd168161d693b2f13ff4f4a4e719303c8e40e2044fb723c4043e4369a74e38::hmstr {
    struct HMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTR>(arg0, 6, b"HMSTR", b"Hamster Kombat", b"Hamster Kombat is a click to earn game that combines a digital currency trading simulator. In this game, the player is the CEO of an emerging digital currency exchange, tasked with taking the exchange to unprecedented heights. To achieve this goal, players need to click on coins to earn coins, and then use these coins to purchase upgrades for the exchange.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_27_21_17_54_9eb97c2a2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

