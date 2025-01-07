module 0x957dd80b20707d607e96fd64ac6217b27e1a2de94461009b7ee96033fb7fa94c::SONIC {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 2, b"SONIC", b"SONIC SNIPE BOT", b"Sonic snipe bot The only trading bot you need, https://www.sonicsnipebot.xyz/, https://x.com/sonicsnipebot, https://t.me/SonicSnipePortal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/hvS5wVx4/sonicsnipebot.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONIC>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SONIC>(&mut v2, 1000000000, @0x6de0e1012e62bc942070615add9026a1c86f22490758462f3bcd0d51ce174dc0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

