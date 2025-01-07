module 0x516671f981b71bcb463bade12e1deec0d70864f8e97e0b9354fab9c5e61771fc::assassincreed {
    struct ASSASSINCREED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSASSINCREED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSASSINCREED>(arg0, 6, b"AssassinCreed", b"Assassin", b"The Assassin's Army, also known as the Order of Assassins, as well as the originally Invisible Ones, is a secret global organization aiming to protect humanity from abuses of power, coercion and injustice. Their traditional method was to kill those who were considered guilty of oppression. The Assassins believed that this would minimize collateral damage in accordance with their absolute prohibition on harming innocent lives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/assassin1_4f5ec00d3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSASSINCREED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASSASSINCREED>>(v1);
    }

    // decompiled from Move bytecode v6
}

