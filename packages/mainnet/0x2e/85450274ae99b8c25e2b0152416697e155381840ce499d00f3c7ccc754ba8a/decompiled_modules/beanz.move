module 0x2e85450274ae99b8c25e2b0152416697e155381840ce499d00f3c7ccc754ba8a::beanz {
    struct BEANZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEANZ>(arg0, 6, b"BEANZ", b"BEANZ on Sui", b"We are BEANZ!We heard that the Sui Network is a new legend in the crypto world, and we love adventure. So we decided to come here to start a new journey with 2010 BEANZ NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736604194800.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEANZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEANZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

