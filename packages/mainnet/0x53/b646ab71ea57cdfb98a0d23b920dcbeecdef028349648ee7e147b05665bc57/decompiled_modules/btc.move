module 0x53b646ab71ea57cdfb98a0d23b920dcbeecdef028349648ee7e147b05665bc57::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"BItcoin", b"Bitcoin is a decentralized digital currency that operates on a peer-to-peer network, allowing users to send and receive payments without the need for intermediaries like banks. It uses blockchain technology to secure transactions and control the crea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732978681647.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

