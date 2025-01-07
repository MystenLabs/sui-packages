module 0x956d218fc8ccdd62b7ff18c33f9683910abb145e3b897baf9c89d977790035ec::dropletsniperbot {
    struct DROPLETSNIPERBOT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DROPLETSNIPERBOT>, arg1: 0x2::coin::Coin<DROPLETSNIPERBOT>) {
        0x2::coin::burn<DROPLETSNIPERBOT>(arg0, arg1);
    }

    fun init(arg0: DROPLETSNIPERBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPLETSNIPERBOT>(arg0, 9, b"droplet sniper bot", b"DROP", b"droplet is the reward token the of droplet sniper bot https://t.me/dropletsniperportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/VEtJZ8e.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPLETSNIPERBOT>>(v1);
        0x2::coin::mint_and_transfer<DROPLETSNIPERBOT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPLETSNIPERBOT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DROPLETSNIPERBOT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DROPLETSNIPERBOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

