module 0xed033d020f7796449b1c845cdde8bca79e2d0a77329f03d014b2daa7896709ae::zacarxfaucet {
    struct ZACARXFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZACARXFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZACARXFAUCET>(arg0, 8, b"ZACARXFAUCET", b"zacarxfaucet", b"we love zacarxfaucet'coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/3om0zV4j9AHvC5KSrcg3iyMU8zOavKhg3uT8q1rwap0")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZACARXFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZACARXFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

