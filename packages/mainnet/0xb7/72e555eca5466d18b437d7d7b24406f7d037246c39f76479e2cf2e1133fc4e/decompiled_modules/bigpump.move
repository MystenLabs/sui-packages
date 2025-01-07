module 0xb772e555eca5466d18b437d7d7b24406f7d037246c39f76479e2cf2e1133fc4e::bigpump {
    struct BIGPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGPUMP>(arg0, 9, b"BIGPUMP", b"Big Pump", b"Sui Big Pump Day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1748108741503803392/EmT4yP6S_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGPUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGPUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

